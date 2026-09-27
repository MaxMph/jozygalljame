extends Node2D

var last_spoon_pos: Vector2
var spoon_dist = 0.0
var won = false
var grabbed = false
@export var grab_radius: float = 30.0
const HAND_HOTSPOT = Vector2(4, 6)
@export var bg_rotate_speed: float = 3.0
var grab_offset = Vector2.ZERO
@export var stir_ratio: float = 0.3
@export var stir_smoothing: float = 3.0
@export var piece_speeds: Array[float] = [1.0, 1.02, 0.985, 1.012, 0.99, 1.006, 0.98]
var piece_targets: Array[float] = []

func _ready() -> void:
	last_spoon_pos = $spoon.global_position
	piece_targets.resize($SoupStuff/Light.get_child_count())
	piece_targets.fill(0.0)
	#print("[soup] ready, spoon at ", $spoon.global_position, " pot center ", $soup/CollisionShape2D.global_position, " radius ", $soup/CollisionShape2D.shape.radius)

func _exit_tree() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse = get_global_mouse_position()
		var local = $spoon.to_local(mouse)
		var dist = mouse.distance_to($spoon.global_position)
		var on_spoon = $spoon.is_pixel_opaque(local) or dist <= grab_radius
		print("[soup] click pressed=", event.pressed, " mouse=", mouse, " spoon_local=", local, " dist=", dist, " on_spoon=", on_spoon, " grabbed=", grabbed)
		if event.pressed and not grabbed and on_spoon:
			grabbed = true
			grab_offset = mouse - $spoon.global_position
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			$hand.visible = true
			update_hand()
			print("[soup] grabbed spoon, mouse captured")
		elif not event.pressed and grabbed:
			grabbed = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			$hand.visible = false
			get_viewport().warp_mouse($spoon.global_position + grab_offset)
			print("[soup] released spoon, cursor warped to ", $spoon.global_position + grab_offset)
	elif event is InputEventMouseMotion and grabbed:
		var center = $soup/CollisionShape2D.global_position
		var old_angle = ($spoon.global_position - center).angle()
		var offset = $spoon.global_position + event.relative - center
		offset = offset.limit_length($soup/CollisionShape2D.shape.radius)
		$spoon.global_position = center + offset
		var turn = angle_difference(old_angle, offset.angle()) * stir_ratio
		for i in piece_targets.size():
			piece_targets[i] += turn * piece_speeds[i % piece_speeds.size()]
		update_hand()
		print("[soup] drag relative=", event.relative, " spoon=", $spoon.global_position)

func update_hand() -> void:
	$hand.global_position = $spoon.global_position + grab_offset - HAND_HOTSPOT

func _process(delta: float) -> void:
	var t = 1.0 - exp(-stir_smoothing * delta)
	for i in piece_targets.size():
		var piece = $SoupStuff/Light.get_child(i)
		piece.rotation = lerpf(piece.rotation, piece_targets[i], t)
		$SoupStuff/Mask/Dark.get_child(i).rotation = piece.rotation
	$SoupBg.rotation_degrees -= bg_rotate_speed * delta

	spoon_dist += last_spoon_pos.distance_to($spoon.global_position)
	last_spoon_pos = $spoon.global_position
	$CanvasLayer/ProgressBar.value = spoon_dist

	if $CanvasLayer/ProgressBar.value >= $CanvasLayer/ProgressBar.max_value:
		if $level_ui.timer_paused == false:
			$level_ui.win()
			won = true
