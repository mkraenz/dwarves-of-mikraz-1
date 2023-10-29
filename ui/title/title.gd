extends Control

@onready var eventbus := Eventbus


func _ready():
	visible = true


func _on_start_pressed():
	eventbus.new_game_pressed.emit()
	visible = false


func _on_quit_pressed():
	get_tree().quit()
