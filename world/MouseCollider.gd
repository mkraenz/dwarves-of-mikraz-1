extends Area2D

@export var hp = 3

@onready var cooldown: Timer = $ClickCooldown

var TIMEOUT = 0.3


func _ready():
	cooldown.one_shot = true
	cooldown.timeout.connect(on_tick)


func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("act"):
		mine()


func mine() -> void:
	if cooldown.is_stopped():
		hp -= 1
		if hp <= 0:
			get_parent().queue_free()
		else:
			cooldown.start(TIMEOUT)


func on_tick() -> void:
	if mouse_entered and Input.is_action_pressed("act"):
		mine()
