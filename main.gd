extends Node

const Level = preload("res://levels/level.tscn")
const Persistence = preload("res://common/persistence/persistence.gd")

@onready var eventbus := Eventbus
@onready var world := $World
@onready var pause_menu := $Gui/Pause
@onready var title_menu := $Gui/Title


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	eventbus.new_game_pressed.connect(_on_new_game_pressed)
	eventbus.load_game_pressed.connect(_on_load_game_pressed)
	eventbus.load_most_recent_game_pressed.connect(_on_load_most_recent_game_pressed)
	eventbus.quit_to_title_pressed.connect(_on_quit_to_title_pressed)
	eventbus.resume_game_pressed.connect(_on_resume_game_pressed)
	title_menu.show()
	pause_menu.hide()


func _input(_event):
	var is_ingame = world.get_child_count() > 0
	if Input.is_action_just_pressed("pause") and is_ingame:
		get_tree().paused = true
		pause_menu.show()


func _on_new_game_pressed() -> void:
	var lvl = Level.instantiate()
	world.add_child(lvl)
	title_menu.hide()
	pause_menu.hide()


func _on_load_game_pressed() -> void:
	var lvl = Level.instantiate()
	world.add_child(lvl)
	var persistence = Persistence.new()
	persistence.load_game(get_tree(), get_node)
	title_menu.hide()
	pause_menu.hide()


func _on_load_most_recent_game_pressed() -> void:
	_on_load_game_pressed()
	title_menu.hide()
	pause_menu.hide()


func _on_quit_to_title_pressed() -> void:
	title_menu.show()
	for node in world.get_children():
		world.remove_child(node)
		node.queue_free()


func _on_resume_game_pressed() -> void:
	get_tree().paused = false
	pause_menu.hide()
