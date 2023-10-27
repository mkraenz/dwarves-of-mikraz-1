extends RigidBody2D

@export var hp = 3

@onready var cooldown: Timer = $ClickCooldown
var TIMEOUT = 0.3


func _ready():
	cooldown.one_shot = true


func _input(event):
	if event is InputEventMouseButton:
		mine()


func mine() -> void:
	if cooldown.is_stopped():
		hp -= 1
		if hp <= 0:
			queue_free()
		else:
			cooldown.start(TIMEOUT)
