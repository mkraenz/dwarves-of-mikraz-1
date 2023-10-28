extends RigidBody2D

var DeathAnim = preload("res://world/crate/crate_death.tscn")
var Pickup = preload("res://world/pickup/pickup.tscn")

@onready var eventbus := Eventbus
@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func die() -> void:
	spawn_pickups()
	spawn_death_effect()
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")


func spawn_death_effect() -> void:
	spawn(DeathAnim)


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
