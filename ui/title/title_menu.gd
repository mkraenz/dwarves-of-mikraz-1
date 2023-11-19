extends Control

const Persistence = preload("res://common/persistence/persistence.gd")

@onready var eventbus := Eventbus
@onready var continue_button := $M/H/V/Buttons/Continue


func _ready():
	refresh()


func _shortcut_input(_event) -> void:
	if OS.has_feature("debug") and Input.is_action_just_pressed("test_new_game"):
		_on_start_pressed()


func _on_start_pressed() -> void:
	eventbus.new_game_pressed.emit()


func _on_load_pressed() -> void:
	eventbus.load_game_pressed.emit()


func _on_continue_pressed():
	eventbus.load_most_recent_game_pressed.emit()


func refresh() -> void:
	var persistence = Persistence.new()
	var exists = persistence.save_game_exists()
	if exists:
		continue_button.show()
	else:
		continue_button.hide()
