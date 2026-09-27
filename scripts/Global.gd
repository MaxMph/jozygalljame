extends Node

const CURSOR_IMAGE = preload("res://art/alien-hand.png")
const CURSOR_CLOSED_IMAGE = preload("res://art/alien-hand-closed.png")
var hand_closed = false
const CURSOR_HOTSPOT = Vector2(4, 6)
const GAME_HEIGHT = 270.0
const CURSOR_MAX_SIZE = 256

func _ready() -> void:
	update_cursor()
	get_window().size_changed.connect(update_cursor)

func set_hand_closed(closed: bool) -> void:
	hand_closed = closed
	update_cursor()

func update_cursor() -> void:
	var scale = get_window().size.y / GAME_HEIGHT
	var img: Image = (CURSOR_CLOSED_IMAGE if hand_closed else CURSOR_IMAGE).get_image()
	var max_dim = max(img.get_width(), img.get_height())
	scale = min(scale, CURSOR_MAX_SIZE / float(max_dim))
	scale = max(scale, 1.0)
	var w = int(round(img.get_width() * scale))
	var h = int(round(img.get_height() * scale))
	var scaled = img.duplicate()
	scaled.resize(w, h, Image.INTERPOLATE_NEAREST)
	Input.set_custom_mouse_cursor(ImageTexture.create_from_image(scaled), Input.CURSOR_ARROW, CURSOR_HOTSPOT * scale)
	print("[cursor] scale=", scale, " size=", w, "x", h)
