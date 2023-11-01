extends RigidBody2D

const DeathAnim = preload("res://world/crate/crate_death.tscn")
const Pickup = preload("res://world/pickup/pickup.tscn")

@onready var eventbus := Eventbus
@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func die() -> void:
	spawn_pickups()
	spawn(DeathAnim)
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")


func spawn_pickups() -> void:
	const RADIUS := 10
	const amount := 3

	for i in range(amount):
		var random_offset_on_circle = Vector2(randf() - 0.5, randf() - 0.5).normalized() * RADIUS
		spawn(Pickup, random_offset_on_circle)


func spawn(Scene: PackedScene, offset := Vector2.ZERO):
	var instance = Scene.instantiate()
	instance.global_position = global_position + offset
	get_tree().current_scene.add_child(instance)
	return instance


func save() -> Dictionary:
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
	}
	return save_dict
