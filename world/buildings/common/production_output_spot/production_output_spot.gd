class_name ProductionOutputSpot
extends Marker2D

const Pickup = preload("res://world/pickup/pickup.tscn")

## Outputs get spawned from on a straight horizontal line around self.global_position. This value provides the range of x values.
@export var spawn_x_half_width: int = 10

var gstate := GState


func spawn(item_id: String, amount: int) -> void:
	var center_offset = spawn_x_half_width
	for i in range(amount):
		var x = lerp(-center_offset, center_offset, float(i) / (amount - 1)) if amount != 1 else 0
		var instance = Pickup.instantiate()
		instance.global_position = global_position + Vector2(x, 0)
		instance.item_id = item_id
		gstate.level.add_child(instance)
