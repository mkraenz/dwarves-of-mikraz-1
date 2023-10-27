extends RigidBody2D

@onready var stats: Stats = $Stats
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready():
	stats.connect("no_health", die)
	stats.connect("hp_changed", bounce)


func die() -> void:
	queue_free()


func bounce(_val) -> void:
	anims.play("bounce")
