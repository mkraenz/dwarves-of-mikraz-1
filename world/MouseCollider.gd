extends Area2D

@onready var cooldown: Timer = $ClickCooldown

var TIMEOUT = 0.6  # identical to animation time of attack


func _ready():
	cooldown.one_shot = true
	cooldown.timeout.connect(on_tick)


func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("act"):
		mine()


func mine() -> void:
	if cooldown.is_stopped():
		var parent_stats = get_node("../Stats")
		assert(
			parent_stats,
			"MouseCollider's parent node must have a Stats node as sibling of MouseCollider"
		)
		parent_stats.hp -= 1
		cooldown.start(TIMEOUT)


func on_tick() -> void:
	if mouse_entered and Input.is_action_pressed("act"):
		mine()
