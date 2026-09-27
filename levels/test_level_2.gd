extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TempAlienHand.global_position = get_local_mouse_position()
	if Input.is_action_just_pressed("left_click"):
		squish()


func squish():
	$TempAlienHand/Area2D/CollisionShape2D.disabled = false
	await get_tree().create_timer(0.1).timeout
	$TempAlienHand/Area2D/CollisionShape2D.disabled = true
	print("sqash")



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("die"):
		area.get_parent().die()
