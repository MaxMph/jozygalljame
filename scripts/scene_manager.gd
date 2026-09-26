extends Node

@export var levels: Array

var oldlevel: String
var newlevel: String

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func change_level(oldlevel, newlevel):
	#scene switch animation stuff later
	if newlevel != "":
		get_tree().change_scene_to_file(newlevel)
		oldlevel = newlevel
