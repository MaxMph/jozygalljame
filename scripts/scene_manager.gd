extends Node

var levels: Array = ["res://levels/soup.tscn", "res://levels/test_level_2.tscn"]

var lives: int = 2

var oldlevel: String
var newlevel: String = "res://ui/main_menu.tscn"

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func next_level():
	if lives <= 0:
		newlevel = "res://ui/main_menu.tscn"
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
