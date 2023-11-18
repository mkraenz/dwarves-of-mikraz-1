extends StaticBody2D

const DeathAnim = preload("res://world/crate/crate_death.tscn")
const Pickup = preload("res://world/pickup/pickup.tscn")

@onready var eventbus := Eventbus
@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var how_to_use := $HowToUse
@onready var shape: CollisionShape2D = $Shape

@export var outputs: Array = [{"item_id": "log", "amount": 3}]


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func mine() -> void:
	stats.hp -= 1


func die() -> void:
	spawn_pickups()
	spawn(DeathAnim)
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")


func spawn_pickups() -> void:
	const RADIUS := 10

	for output in outputs:
		for i in range(output.amount):
			var random_offset_on_circle = (
				Vector2(randf() - 0.5, randf() - 0.5).normalized() * RADIUS
			)
			var instance = Pickup.instantiate()
			instance.global_position = global_position + random_offset_on_circle
			instance.item_id = output.item_id
			get_parent().add_child(instance)


func spawn(Scene: PackedScene, offset := Vector2.ZERO):
	var instance = Scene.instantiate()
	instance.global_position = global_position + offset
	get_parent().add_child(instance)
	return instance


func save() -> Dictionary:
	var save_dict = {
		"file_id": "crate_tmMrzy",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"outputs": outputs
	}
	return save_dict


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	how_to_use.hide()


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
