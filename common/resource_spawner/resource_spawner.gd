extends Node2D

const Crate = preload("res://world/crate/crate.tscn")


func _on_cooldown_timeout():
	spawn_resource()


func spawn_resource() -> void:
	var crate = Crate.instantiate()
	crate.global_position = random_vector2()
	add_child(crate)


func random_vector2() -> Vector2:
	var x = randf_range(16, 320 - 16)
	var y = randf_range(16, 180 - 16)
	return Vector2(x, y)
