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
@onready var mining := $Mining

## @type {keyof typeof ResourceNodeData}
@export var resource_node_type: String = "iron_ore"


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", _on_hit)


func mine() -> void:
	stats.hp -= 1


func die() -> void:
	mining.output_resources()
	# spawn(DeathAnim)
	queue_free()


func _on_hit(_val) -> void:
	anims.play("hit")


func save() -> Dictionary:
	var save_dict = {
		"file_id": "iron_ore_ufkPN4",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
	}
	return save_dict


func mark() -> void:
	how_to_act.show()


func unmark() -> void:
	how_to_act.hide()


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
