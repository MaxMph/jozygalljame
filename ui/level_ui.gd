extends Control

@export var timerLength: float = 5.0

func _ready() -> void:
	#get_tree().create_timer()
	$AnimationPlayer.play("fade in")

func _process(delta: float) -> void:
	timerLength -= delta
	if timerLength <= 0:
		level_end()
	$timer.text = str(ceil(timerLength))

func level_end():
	$AnimationPlayer.play("fade_out")
	#await $AnimationPlayer.animation_finished
	#get_tree().change_scene_to_file()
	


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		get_tree().reload_current_scene()
