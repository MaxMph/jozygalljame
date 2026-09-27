extends Node2D


var speed = 200
var target_pos
var dist_margin = 10
@export var far_corner: Vector2

func _ready() -> void:
	new_target()

func _physics_process(delta: float) -> void:
	#if abs(position - target_pos) > dist_margin
	if position.distance_to(target_pos) > dist_margin:
		position = position.move_toward(target_pos, speed * delta)
		#print(str(position))
	else:
		new_target()

func new_target():
	target_pos = Vector2(randf_range(0, far_corner.x), randf_range(0, far_corner.y))
	#print("new target: " + str(target_pos))

func die():
	speed = 0
