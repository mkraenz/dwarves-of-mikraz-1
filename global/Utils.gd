class_name Utils
extends Node


static func remove_all_children(parent: Node, immediate = false) -> void:
	for node in parent.get_children():
		parent.remove_child(node)
		if immediate:
			node.free()
		else:
			node.queue_free()


static func sample(arr: Array[Variant]) -> Variant:
	return arr[randi() % len(arr)]


static func spawn(
	Scene: PackedScene, global_position: Vector2, parent: Node2D, offset := Vector2.ZERO
):
	var instance = Scene.instantiate()
	instance.global_position = global_position + offset
	parent.add_child(instance)
	return instance


static func random_unit_vector() -> Vector2:
	return Vector2(randf() - 0.5, randf() - 0.5).normalized()
