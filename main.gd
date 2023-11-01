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
	eventbus.save_game_pressed.connect(_on_save_game_pressed)
	title_menu.show()
	pause_menu.hide()


func _input(_event):
	var is_ingame = world.get_child_count() > 0
	if Input.is_action_just_pressed("pause") and is_ingame:
		get_tree().paused = true
		pause_menu.show()


func _on_save_game_pressed() -> void:
	var persistence = Persistence.new()
	persistence.save_game(get_tree())
	_on_resume_game_pressed()
	eventbus.game_saved_successfully.emit()


func _on_new_game_pressed() -> void:
	var lvl = Level.instantiate()
	world.add_child(lvl)
	unpause_game()


func _on_load_game_pressed() -> void:
	for child in world.get_children():
		child.free()  # queue_free would cause the next two lines to instantiate under the node path '/root/Main/World/Level2' instead of 'Level'. The persistence however uses the node paths '/root/Main/World/Level/Tilemap/Player' etc that depend on the naming 'Level'.
	var lvl = Level.instantiate()
	world.add_child(lvl, true)
	var persistence = Persistence.new()
	persistence.load_game(get_tree(), get_node)
	unpause_game()


func _on_load_most_recent_game_pressed() -> void:
	_on_load_game_pressed()


func _on_quit_to_title_pressed() -> void:
	title_menu.show()
	for node in world.get_children():
		world.remove_child(node)
		node.queue_free()


func _on_resume_game_pressed() -> void:
	unpause_game()


func unpause_game() -> void:
	get_tree().paused = false  # only needed when we're in pause menu but also doesn't hurt to do from title menu
	title_menu.hide()
	pause_menu.hide()
