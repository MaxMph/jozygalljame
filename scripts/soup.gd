extends Node2D

var last_spoon_pos: Vector2
var spoon_dist = 0.0
var won = false
func _ready() -> void:
	last_spoon_pos = $spoon.global_position

func _process(delta: float) -> void:
	if get_local_mouse_position().distance_to($soup/CollisionShape2D.global_position) <= $soup/CollisionShape2D.shape.radius:
		$spoon.global_position = get_local_mouse_position()
		
	
	spoon_dist += last_spoon_pos.distance_to($spoon.global_position)
	last_spoon_pos = $spoon.global_position
	$CanvasLayer/ProgressBar.value = spoon_dist
	
	if $CanvasLayer/ProgressBar.value >= $CanvasLayer/ProgressBar.max_value:
	#if $CanvasLayer/ProgressBar.value >= spoon_dist and won == false:
		$level_ui.win()
		won = true
	
		#print("works")
	#print(get_local_mouse_position().distance_to($soup/CollisionShape2D.global_position))
	#print($soup/CollisionShape2D.shape.radius)
