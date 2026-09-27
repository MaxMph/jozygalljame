extends Node

var levels: Array = ["res://levels/soup.tscn", "res://levels/test_level_2.tscn"]

var oldlevel: String
var newlevel: String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func next_level():
	newlevel = levels.pick_random()
	change_level()

func change_level():
	#scene switch animation stuff later
	if newlevel != "":
		get_tree().change_scene_to_file(newlevel)
		oldlevel = newlevel
