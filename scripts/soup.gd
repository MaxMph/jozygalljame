extends Node2D

var last_mouse_pos
func _ready() -> void:
	last_mouse_pos = get_local_mouse_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_pressed("left_click"):
		#
	if get_local_mouse_position().distance_to($soup/CollisionShape2D.global_position) <= $soup/CollisionShape2D.shape.radius:
		$spoon.global_position = get_local_mouse_position()
		#print("works")
	#print(get_local_mouse_position().distance_to($soup/CollisionShape2D.global_position))
	#print($soup/CollisionShape2D.shape.radius)
