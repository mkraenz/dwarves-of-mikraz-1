extends Control

@onready var eventbus := Eventbus


func _ready():
	hide()


func _on_start_pressed() -> void:
	eventbus.new_game_pressed.emit()
	hide()


func _on_load_pressed() -> void:
	eventbus.load_game_pressed.emit()
	hide()


func _on_continue_pressed():
	eventbus.continue_game_pressed.emit()
	hide()


func _on_quit_to_desktop_pressed():
	get_tree().quit()


func _on_quit_to_title_pressed():
	eventbus.quit_to_title_pressed.emit()
