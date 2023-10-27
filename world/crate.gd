extends RigidBody2D

@onready var stats: Stats = $Stats


func _ready():
	stats.connect("no_health", die)


func die() -> void:
	queue_free()
