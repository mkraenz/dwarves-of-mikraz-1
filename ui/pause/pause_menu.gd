extends Control

@onready var eventbus := Eventbus


func _on_load_pressed() -> void:
	eventbus.load_game_pressed.emit()


func _on_quit_to_desktop_pressed():
	get_tree().quit()


func _on_quit_to_title_pressed():
	eventbus.quit_to_title_pressed.emit()


func _on_resume_pressed():
	eventbus.resume_game_pressed.emit()


func _on_save_pressed():
	eventbus.save_game_pressed.emit()
