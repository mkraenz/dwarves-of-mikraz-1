extends Node2D

const Crate = preload("res://world/crate/crate.tscn")

@export var enabled = true

var gstate := GState


func _on_cooldown_timeout():
	if enabled:
		spawn_resource()


func spawn_resource() -> void:
	var crate = Crate.instantiate()
	crate.global_position = random_vector2()
	add_child(crate)


func random_vector2() -> Vector2:
	DisplayServer.window_get_size()
	var dim: Vector2 = get_viewport().get_visible_rect().size / gstate.cam.zoom
	var inset := 16
	var x = randf_range(inset, dim.x - inset)
	var y = randf_range(inset, dim.y - inset)
	return Vector2(x, y)
