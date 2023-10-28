extends RigidBody2D

var DeathAnim = preload("res://world/crate/crate_death.tscn")

@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func die() -> void:
	var death = DeathAnim.instantiate()
	death.global_position = global_position
	get_tree().current_scene.add_child(death)
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")
