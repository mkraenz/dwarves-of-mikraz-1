extends Node

var Level = preload("res://levels/level.tscn")

@onready var eventbus := Eventbus
@onready var world := $World


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	eventbus.new_game_pressed.connect(_on_new_game_pressed)


func _on_new_game_pressed() -> void:
	var lvl = Level.instantiate()
	world.add_child(lvl)
