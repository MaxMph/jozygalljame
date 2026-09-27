extends Control


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	SceneManager.next_level()
