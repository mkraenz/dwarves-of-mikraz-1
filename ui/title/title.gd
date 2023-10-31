extends Control

@onready var eventbus := Eventbus


func _on_start_pressed() -> void:
	eventbus.new_game_pressed.emit()
	hide()


func _on_load_pressed() -> void:
	eventbus.load_game_pressed.emit()
	hide()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_continue_pressed():
	eventbus.load_most_recent_game_pressed.emit()
	hide()


func _on_options_pressed():
	# TODO
	pass  # Replace with function body.
