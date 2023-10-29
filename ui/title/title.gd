extends Control

@onready var eventbus := Eventbus


func _ready():
	visible = true


func _on_start_pressed() -> void:
	eventbus.new_game_pressed.emit()
	visible = false


func _on_load_pressed() -> void:
	eventbus.load_game_pressed.emit()
	visible = false


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_continue_pressed():
	eventbus.continue_game_pressed.emit()
	visible = false
