extends Node2D

const Pickup = preload("res://world/pickup/pickup.tscn")

## @type {keyof typeof ResourceNodeData}
@export var resource_node_type: String
@export var reference_node: Node2D

var gstate := GState
var gdata := GData


func output_resources() -> void:
	var resource_node = gdata.get_resource_node(resource_node_type)
	_spawn_pickups(resource_node.outputs)


## @param {OutputItem[]} outputs
func _spawn_pickups(outputs: Array) -> void:
	const RADIUS := 10

	for output in outputs:
		for i in range(output.amount):
			var random_offset_on_circle = (
				Vector2(randf() - 0.5, randf() - 0.5).normalized() * RADIUS
			)
			var instance = Pickup.instantiate()
			instance.global_position = global_position + random_offset_on_circle
			instance.item_id = output.id
			gstate.level.add_child(instance)


func spawn(Scene: PackedScene, offset := Vector2.ZERO):
	var instance = Scene.instantiate()
	instance.global_position = reference_node.global_position + offset
	gstate.level.add_child(instance)
	return instance
