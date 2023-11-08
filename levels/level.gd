extends Node2D

const Crate = preload("res://world/crate/crate.tscn")
const Pickup = preload("res://world/pickup/pickup.tscn")
const Sawmill = preload("res://world/buildings/sawmill/sawmill.tscn")

var eventbus := Eventbus


# TODO this is debug code and should probably not be in a build
func _input(_event) -> void:
	# spawn at mouse position
	if Input.is_action_just_pressed("test"):
		var instance := Sawmill.instantiate()
		var pos := get_global_mouse_position()
		instance.global_position = pos
		add_child(instance)

	if Input.is_action_just_pressed("toggle_building_menu"):
		eventbus.toggle_building_menu.emit()


func _on_production_takt_timeout():
	eventbus.production_tick.emit()
