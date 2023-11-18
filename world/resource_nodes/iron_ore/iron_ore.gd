extends StaticBody2D

# const DeathAnim = preload("res://world/resource_nodes/crate/crate_death.tscn")
const Pickup = preload("res://world/pickup/pickup.tscn")

var eventbus := Eventbus
var gdata := GData
var gstate := GState
@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var how_to_act := $HowToAct
@onready var shape: CollisionShape2D = $Shape

## @type {keyof typeof ResourceNodeData}
@export var resource_node_type: String = "iron_ore"


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", _on_hit)


func mine() -> void:
	stats.hp -= 1


func die() -> void:
	var resource_node = gdata.get_resource_node(resource_node_type)
	spawn_pickups(resource_node.outputs)
	# spawn(DeathAnim)
	queue_free()


func _on_hit(_val) -> void:
	anims.play("hit")


## @param {OutputItem[]} outputs
func spawn_pickups(outputs: Array) -> void:
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
	instance.global_position = global_position + offset
	gstate.level.add_child(instance)
	return instance


func save() -> Dictionary:
	var save_dict = {
		"file_id": "iron_ore_ufkPN4",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"resource_node_type": resource_node_type
	}
	return save_dict


func mark() -> void:
	how_to_act.show()


func unmark() -> void:
	how_to_act.hide()


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
