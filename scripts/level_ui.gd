extends Node

@export var timerLength: float = 5.0
@export var won: bool = false
var timer_paused = false

func _ready() -> void:
	$level_ui/AnimationPlayer.play("fade in")
	var count = 0
	for i in $level_ui/HBoxContainer.get_children():
		if count <= SceneManager.lives - 1:
			i.visible = true
			count += 1

func _process(delta: float) -> void:
	if timerLength <= 0:
		if !timer_paused:
			timer_paused = true
			$level_ui/timer.text = "0"
			#level_end()
			if won:
				win()
			else:
				lose()
	else:
		timerLength -= delta
		$level_ui/timer.text = str(ceil(timerLength))

func level_end():
	#print(timerLength)
	#if $level_ui/AnimationPlayer.is_playing() == false:
	if $level_ui/AnimationPlayer.current_animation != "fade_out":
		$level_ui/AnimationPlayer.play("fade_out")
		#await $level_ui/AnimationPlayer.animation_finished
		##get_tree().change_scene_to_file()
		#get_tree().reload_current_scene()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		#emit_signal()
		#print("faded")
		#get_tree().reload_current_scene()
		#SceneManager.change_level()
		
		SceneManager.next_level()

func win():
	timer_paused = true
	$level_ui/win_screen.show()
	await get_tree().create_timer(0.6).timeout
	#$level_ui/win_screen.hide()
	level_end()

func lose():
	$level_ui/lose_screen.show()
	lose_life()
	await get_tree().create_timer(0.6).timeout
	#$level_ui/lose_screen.hide()
	level_end()

func lose_life():
	for i in $level_ui/HBoxContainer.get_children():
		if i.visible == true:
			i.visible = false
			break
			#make animation for losing heart
	SceneManager.lives -= 1
	print(SceneManager.lives)
	
