extends Node2D

const Crate = preload("res://world/resource_nodes/crate/crate.tscn")

@export var enabled := true

var gstate := GState

const COLLISION_SCALE_FOR_PLACEMENT_CHECK: float = 2.0
const NORMAL_COLLISION_SCALE: float = 1.0


func _on_cooldown_timeout():
	if enabled:
		spawn_resource(Crate)


func spawn_resource(Scene: PackedScene, attempt = 0) -> void:
	if attempt > 10:
		printt(name, "Collision while searching for spawn position reached max attempts. aborting.")
		return
	var instance = Scene.instantiate()
	var original_collision_layer = instance.collision_layer
	instance.collision_layer = 0  # disable collision to not move the object
	instance.global_position = random_vector2()
	add_child(instance)
	scale_collision_shape(instance, COLLISION_SCALE_FOR_PLACEMENT_CHECK)
	var invalid_placement = instance.test_move(instance.transform, Vector2.ZERO)
	if invalid_placement:
		remove_child(instance)
		spawn_resource(Scene, attempt + 1)
	else:
		instance.collision_layer = original_collision_layer  # reenable collision for a valid object
		scale_collision_shape(instance, NORMAL_COLLISION_SCALE)


func random_vector2() -> Vector2:
	DisplayServer.window_get_size()
	var dim: Vector2 = Vector2(gstate.cam.limit_right, gstate.cam.limit_bottom)
	var inset := 16
	var x = randf_range(inset, dim.x - inset)
	var y = randf_range(inset, dim.y - inset)
	return Vector2(x, y)


func scale_collision_shape(instance: Node2D, new_scale: float) -> void:
	if instance.has_method("set_collision_scale"):
		instance.set_collision_scale(new_scale)
	else:
		push_error("instance is missing 'set_collision_scale'. instance.name", instance.name)
