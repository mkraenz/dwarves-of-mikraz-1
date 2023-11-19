extends Node

const Persistence = preload("res://common/persistence/persistence.gd")
const MyCamera = preload("res://common/camera/my_camera.tscn")
const Player = preload("res://player/Player.tscn")

var eventbus := Eventbus
var gstate := GState
@onready var world := $World
@onready var pause_menu := $Gui/OutgameMenus/PauseMenu
@onready var title_menu := $Gui/OutgameMenus/TitleMenu
@onready var options_menu := $Gui/OutgameMenus/OptionsMenu
@onready var ingame_menus := $Gui/IngameMenus
@onready var outgame_menus := $Gui/OutgameMenus


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	eventbus.new_game_pressed.connect(_on_new_game_pressed)
	eventbus.load_game_pressed.connect(_on_load_game_pressed)
	eventbus.load_most_recent_game_pressed.connect(_on_load_most_recent_game_pressed)
	eventbus.quit_to_title_pressed.connect(_on_quit_to_title_pressed)
	eventbus.resume_game_pressed.connect(_on_resume_game_pressed)
	eventbus.save_game_pressed.connect(_on_save_game_pressed)
	eventbus.toggle_options_menu.connect(_on_toggle_options_menu)


func is_ingame() -> bool:
	return not title_menu.visible and not get_tree().paused and world.get_child_count() > 0


func _input(_event):
	if Input.is_action_just_pressed("pause"):
		if is_ingame():
			pause_game()
		else:
			unpause_game()


func _on_save_game_pressed() -> void:
	var persistence = Persistence.new()
	persistence.save_game(get_tree())
	_on_resume_game_pressed()
	eventbus.game_saved_successfully.emit()
	eventbus.show_notification.emit("Saved successfully.", 2)


func _on_new_game_pressed() -> void:
	eventbus.scene_transition_hide.emit()
	world.setup_new_level()
	await eventbus.scene_transition_finished
	unpause_game()
	eventbus.scene_transition_show.emit()


func _on_load_game_pressed() -> void:
	eventbus.scene_transition_hide.emit()
	world.clear(true)  # queue_free (i.e. force=false) would cause the next two lines to instantiate under the node path '/root/Main/World/Level2' instead of 'Level'. The persistence however uses the node paths '/root/Main/World/Level/Player' etc that depend on the naming 'Level'.
	gstate.reset()

	world.setup_empty_level()
	var persistence = Persistence.new()
	persistence.load_game(get_tree(), get_node)
	await eventbus.scene_transition_finished
	unpause_game()
	eventbus.scene_transition_show.emit()


func _on_load_most_recent_game_pressed() -> void:
	_on_load_game_pressed()


func _on_quit_to_title_pressed() -> void:
	eventbus.scene_transition_hide.emit()
	world.clear()
	await eventbus.scene_transition_finished
	unpause_game()
	title_menu.show()
	title_menu.refresh()
	eventbus.scene_transition_show.emit()


func _on_resume_game_pressed() -> void:
	unpause_game()


func pause_game() -> void:
	get_tree().paused = true
	pause_menu.show()


func unpause_game() -> void:
	get_tree().paused = false
	outgame_menus.hide_children()
	ingame_menus.hide_children()


func _on_toggle_options_menu() -> void:
	options_menu.visible = not options_menu.visible
