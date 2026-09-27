extends Node

var levels: Array = ["res://levels/apples.tscn", "res://levels/soup.tscn", "res://levels/knittings.tscn"]

var lives: int = 3
var lives_base_amount = 3

var oldlevel: String
var newlevel: String = "res://ui/main_menu.tscn"

#var audio_manager_scene = preload("res://audio_manager.tscn")

func _ready() -> void:
	pass
	#add_child(audio_manager_scene.instantiate())

func _process(delta: float) -> void:
	pass

func next_level():
	if lives <= 0:
		newlevel = "res://ui/main_menu.tscn"
		lives = lives_base_amount
	else:
		newlevel = levels.pick_random()
	
	#newlevel = "res://scripts/main_menu.gd"
	change_level()

func change_level():
	#scene switch animation stuff later
	if newlevel != "":
		get_tree().change_scene_to_file(newlevel)
		await get_tree().scene_changed
		oldlevel = newlevel
		print(get_tree().current_scene)
