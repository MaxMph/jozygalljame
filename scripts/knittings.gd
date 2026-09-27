extends Node2D

var left = true
var won = false

var stitches = 0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and left:
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("p1")
		left = false
		stitches += 1
	if Input.is_action_just_pressed("right_click") and !left:
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("p2")
		left = true
		stitches += 1
		
	if stitches >= 25 and !won:
		$level_ui.win()
		print("win")
		
