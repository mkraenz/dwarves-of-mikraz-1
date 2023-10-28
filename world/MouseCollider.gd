extends Area2D

@onready var cooldown: Timer = $ClickCooldown
@onready var player_hit_timer: Timer = $PlayerAnimHitTimer
@onready var gstate := GState

var TIMEOUT = 0.6  # identical to animation time of Player attack
var TIMEOUT_TO_CONNECT = 0.2  # identical to time of Player attack animation when weapon connects with object

var mouse_hovering = false


func _ready():
	cooldown.one_shot = true
	player_hit_timer.one_shot = true
	cooldown.timeout.connect(on_cooldown_tick)
	player_hit_timer.timeout.connect(on_hit_connect)
	mouse_entered.connect(func(): mouse_hovering = true)
	mouse_exited.connect(func(): mouse_hovering = false)


func _input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("act"):
		if cooldown.is_stopped():
			var parent = get_parent()
			if parent in gstate.bodies_in_player_action_radius:
				player_hit_timer.start(TIMEOUT_TO_CONNECT)
				cooldown.start(TIMEOUT)


func mine() -> void:
	var parent_stats = get_node("../Stats")
	assert(
		parent_stats,
		"MouseCollider's parent node must have a Stats node as sibling of MouseCollider"
	)
	parent_stats.hp -= 1


func on_cooldown_tick() -> void:
	if mouse_hovering and Input.is_action_pressed("act"):
		player_hit_timer.start(TIMEOUT_TO_CONNECT)
		cooldown.start(TIMEOUT)


func on_hit_connect() -> void:
	mine()
