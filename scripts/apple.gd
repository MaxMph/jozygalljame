extends Sprite2D

signal collected(apple)

enum State { BRANCH, HELD, FALLING, LANDED }

const GRAVITY = 900.0
const SCREEN_HEIGHT = 270.0
const TILT_PER_SPEED = 0.0025
const MAX_TILT = 0.6
const TILT_SMOOTHING = 10.0

var good = false
var state = State.BRANCH
var velocity = 0.0
var barrel_rect = Rect2()
var in_barrel = false
var last_position = Vector2.ZERO

func drop() -> void:
	state = State.FALLING
	velocity = 0.0
	in_barrel = false

func _process(delta: float) -> void:
	var t = 1.0 - exp(-TILT_SMOOTHING * delta)
	if state == State.HELD:
		var speed_x = (position.x - last_position.x) / delta
		var target = clampf(speed_x * TILT_PER_SPEED, -MAX_TILT, MAX_TILT)
		rotation = lerpf(rotation, target, t)
	else:
		rotation = lerpf(rotation, 0.0, t)
	last_position = position
	if state != State.FALLING:
		return
	velocity += GRAVITY * delta
	position.y += velocity * delta
	var floor_y = SCREEN_HEIGHT - texture.get_height() / 2.0
	if in_barrel or barrel_rect.has_point(position):
		in_barrel = true
		if position.y > SCREEN_HEIGHT + texture.get_height():
			collected.emit(self)
			queue_free()
	elif position.y >= floor_y:
		position.y = floor_y
		state = State.LANDED

func hit(point: Vector2, radius: float) -> bool:
	return is_pixel_opaque(to_local(point)) or point.distance_to(global_position) <= radius
