extends StaticBody2D

const DeathAnim = preload("res://world/resource_nodes/crate/crate_death.tscn")

var eventbus := Eventbus
var gdata := GData
var gstate := GState
@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var shape: CollisionShape2D = $Shape
@onready var mining = $Mining


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func mine() -> void:
	stats.hp -= 1 if not FeatureFlags.over_nine_thousand else 9999


func die() -> void:
	mining.output_resources()
	Utils.spawn(DeathAnim, global_position, gstate.level)
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")


func save() -> Dictionary:
	var save_dict = {
		"file_id": "crate_tmMrzy",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"stats": stats.save(),
	}
	return save_dict


func load_before_ready(save_dict: Dictionary) -> void:
	$Stats.load_from(save_dict.stats)


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
