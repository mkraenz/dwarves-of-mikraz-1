extends Node2D

const Level = preload("res://levels/level.tscn")
const Player = preload("res://player/Player.tscn")

@onready var cam := $Cam

var level: Node2D
var player: Player


func setup_new_level() -> void:
	setup_empty_level()
	_setup_player()


func setup_empty_level() -> void:
	var lvl = Level.instantiate()
	add_child(lvl)

	level = lvl


func _setup_player() -> void:
	var _player = Player.instantiate()
	_player.global_position = Vector2(100, 100)
	level.add_child(_player, true)
	_player.connect_camera(cam)

	player = _player


func clear(immediate = false) -> void:
	var nodes = get_tree().get_nodes_in_group("destroy")
	for node in nodes:
		if immediate:
			node.free()
		else:
			node.queue_free()
