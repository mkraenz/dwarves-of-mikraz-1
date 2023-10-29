extends Node

const Level = preload("res://levels/level.tscn")
const Persistence = preload("res://common/persistence/persistence.gd")

@onready var eventbus := Eventbus
@onready var world := $World


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	eventbus.new_game_pressed.connect(_on_new_game_pressed)
	eventbus.load_game_pressed.connect(_on_load_game_pressed)
	eventbus.continue_game_pressed.connect(_on_continue_game_pressed)


func _on_new_game_pressed() -> void:
	var lvl = Level.instantiate()
	world.add_child(lvl)


func _on_load_game_pressed():
	var lvl = Level.instantiate()
	world.add_child(lvl)
	var persistence = Persistence.new()
	persistence.load_game(get_tree(), get_node)


func _on_continue_game_pressed():
	_on_load_game_pressed()
