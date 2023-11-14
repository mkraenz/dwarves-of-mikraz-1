extends Node2D

const Crate = preload("res://world/crate/crate.tscn")

@export var enabled = true

var gstate := GState


func _on_cooldown_timeout():
	if enabled:
		spawn_resource()


func spawn_resource(attempt = 0) -> void:
	if attempt > 10:
		prints("collision reached max attempts. aborting.")
		return
	var instance = Crate.instantiate()
	var original_collision_layer = instance.collision_layer
	instance.collision_layer = 0  # disable collision to not move the object
	instance.global_position = random_vector2()
	add_child(instance)
	var colliding = instance.test_move(instance.transform, Vector2.ZERO)
	if colliding:
		remove_child(instance)
		spawn_resource(attempt + 1)
	else:
		instance.collision_layer = original_collision_layer  # reenable collision for a valid object


func random_vector2() -> Vector2:
	DisplayServer.window_get_size()
	var dim: Vector2 = Vector2(gstate.cam.limit_right, gstate.cam.limit_bottom)
	var inset := 16
	var x = randf_range(inset, dim.x - inset)
	var y = randf_range(inset, dim.y - inset)
	return Vector2(x, y)
