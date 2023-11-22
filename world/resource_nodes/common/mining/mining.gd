extends Node2D
class_name Mining

const Pickup = preload("res://world/pickup/pickup.tscn")

## @type {keyof typeof ResourceNodeData}
@export var resource_node_type: String
@export var reference_node: Node2D

var gstate := GState
var gdata := GData

const SPAWN_RADIUS := 10


func output_resources() -> void:
	var resource_node = gdata.get_resource_node(resource_node_type)
	_spawn_pickups(resource_node.outputs)


## @param {OutputItem[]} outputs
func _spawn_pickups(outputs: Array) -> void:
	var pickups := []
	for output in outputs:
		for i in output.amount:
			var instance = new_pickup(output)
			pickups.append(instance)

	for pickup in pickups:
		gstate.level.add_child(pickup)


func new_pickup(output: Dictionary) -> Node2D:
	var random_offset_on_circle = Utils.random_unit_vector() * SPAWN_RADIUS
	var instance = Pickup.instantiate()
	instance.global_position = reference_node.global_position + random_offset_on_circle
	instance.item_id = output.id
	return instance
