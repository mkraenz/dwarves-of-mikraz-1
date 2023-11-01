extends Node2D

const Crate = preload("res://world/crate/crate.tscn")
const Pickup = preload("res://world/pickup/pickup.tscn")


# TODO this is debug code and should probably not be in a build
func _input(_event) -> void:
	# spawn at mouse position
	if Input.is_action_pressed("test"):
		var instance := Pickup.instantiate()
		var pos := get_global_mouse_position()
		instance.global_position = pos
		add_child(instance)
