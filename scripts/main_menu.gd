extends Control


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	AudioManager.play_sound("game_start")
	SceneManager.next_level()
