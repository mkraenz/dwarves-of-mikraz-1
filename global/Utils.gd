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
