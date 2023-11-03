extends Node

const Persistence = preload("res://common/persistence/persistence.gd")
const MyCamera = preload("res://common/camera/my_camera.tscn")
const Player = preload("res://player/Player.tscn")

var eventbus := Eventbus
var gstate := GState
@onready var world := $World
@onready var pause_menu := $Gui/PauseMenu
@onready var title_menu := $Gui/TitleMenu


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


func is_ingame() -> bool:
	return not title_menu.visible and not get_tree().paused and world.get_child_count() > 0


func _input(_event):
	if Input.is_action_just_pressed("pause") and is_ingame():
		get_tree().paused = true
		pause_menu.show()


func _on_save_game_pressed() -> void:
	var persistence = Persistence.new()
	persistence.save_game(get_tree())
	_on_resume_game_pressed()
	eventbus.game_saved_successfully.emit()


func _on_new_game_pressed() -> void:
	world.setup_new_level()
	unpause_game()


func _on_load_game_pressed() -> void:
	world.clear(true)  # queue_free (i.e. force=false) would cause the next two lines to instantiate under the node path '/root/Main/World/Level2' instead of 'Level'. The persistence however uses the node paths '/root/Main/World/Level/Tilemap/Player' etc that depend on the naming 'Level'.
	gstate.reset()

	world.setup_empty_level()
	var persistence = Persistence.new()
	persistence.load_game(get_tree(), get_node)
	unpause_game()


func _on_load_most_recent_game_pressed() -> void:
	_on_load_game_pressed()


func _on_quit_to_title_pressed() -> void:
	world.clear()
	unpause_game()
	title_menu.show()
	title_menu.refresh()


func _on_resume_game_pressed() -> void:
	unpause_game()


func unpause_game() -> void:
	get_tree().paused = false  # only needed when we're in pause menu but also doesn't hurt to do from title menu
	title_menu.hide()
	pause_menu.hide()

# func attach_player_camera() -> void:
# 	var player = get_tree().get_nodes_in_group("Player")[0]
# 	var cam = MyCamera.instantiate()
# 	player.add_child(cam)
