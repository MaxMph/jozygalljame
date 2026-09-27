extends Node2D

const APPLE_SCRIPT = preload("res://scripts/apple.gd")
const GOOD_TEXTURES = [
	preload("res://art/apple-good-1.png"),
	preload("res://art/apple-good-2.png"),
	preload("res://art/apple-good-3.png"),
]
const BAD_TEXTURES = [
	preload("res://art/apple-bad-1.png"),
	preload("res://art/apple-bad-2.png"),
]

@export var good_count = 3
@export var bad_count = 2
@export var grab_radius: float = 16.0
@export var barrel_rect = Rect2(64, 236, 122, 34)

var held: Sprite2D = null
var grab_offset = Vector2.ZERO
var collected_good = 0
var done = false

func _ready() -> void:
	var spots = $Spawns.get_children()
	spots.shuffle()
	var good_pool = GOOD_TEXTURES.duplicate()
	var bad_pool = BAD_TEXTURES.duplicate()
	good_pool.shuffle()
	bad_pool.shuffle()
	for i in good_count + bad_count:
		var apple = Sprite2D.new()
		apple.set_script(APPLE_SCRIPT)
		apple.good = i < good_count
		var pool = good_pool if apple.good else bad_pool
		apple.texture = pool[(i if apple.good else i - good_count) % pool.size()]
		apple.offset = Vector2(apple.texture.get_width() % 2, apple.texture.get_height() % 2) * 0.5
		apple.position = spots[i].position
		apple.barrel_rect = barrel_rect
		apple.collected.connect(_on_apple_collected)
		$Apples.add_child(apple)

func _exit_tree() -> void:
	Global.set_hand_closed(false)

func _input(event: InputEvent) -> void:
	if done:
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse = get_global_mouse_position()
		if event.pressed and held == null:
			var apples = $Apples.get_children()
			apples.reverse()
			for apple in apples:
				if apple.state != apple.State.FALLING and apple.hit(mouse, grab_radius):
					held = apple
					held.state = apple.State.HELD
					held.last_position = held.position
					grab_offset = held.global_position - mouse
					$Apples.move_child(held, -1)
					Global.set_hand_closed(true)
					break
		elif not event.pressed and held != null:
			held.drop()
			held = null
			Global.set_hand_closed(false)
	elif event is InputEventMouseMotion and held != null:
		held.global_position = get_global_mouse_position() + grab_offset

func _on_apple_collected(apple) -> void:
	if done or $level_ui.timer_paused:
		return
	if apple.good:
		collected_good += 1
		if collected_good >= good_count:
			done = true
			$level_ui.win()
	else:
		done = true
		$level_ui.lose()
