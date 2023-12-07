extends CharacterBody2D
class_name Player

@export var speed = 150

@onready var audio_anims := $AnimationPlayer
@onready var anim_tree: AnimationTree = $AnimationTree
@onready var cam_remote := $CamRemote
@onready var gstate := GState
@onready var action_radius: ActionRadius = $ActionRadius

var lock_animation = false


func _ready():
	anim_tree.active = true


func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	if gstate.player_input_blocked:
		animate_idle()
		return
	else:
		set_process_input(true)
	get_input()
	move_and_slide()
	update_anim_params()


func animate_idle() -> void:
	anim_tree["parameters/conditions/idle"] = true
	anim_tree["parameters/conditions/is_moving"] = false
	anim_tree["parameters/conditions/attack"] = false


func update_anim_params() -> void:
	if velocity.x != 0:
		anim_tree["parameters/idle/blend_position"] = velocity.x
		anim_tree["parameters/move/blend_position"] = velocity.x

	if velocity == Vector2.ZERO:
		anim_tree["parameters/conditions/idle"] = true
		anim_tree["parameters/conditions/is_moving"] = false
	else:
		anim_tree["parameters/conditions/idle"] = false
		anim_tree["parameters/conditions/is_moving"] = true

	# without animation lock, when attacking and wiggling left and right on the keyboard, the attack wiggles between attack_left and attack_right, never actually swinging the axe
	if Input.is_action_pressed("act") and not lock_animation:
		face("mine")
		anim_tree["parameters/conditions/attack"] = true
	else:
		anim_tree["parameters/conditions/attack"] = false


func _locked_anim_started() -> void:
	lock_animation = true


func _locked_anim_finished() -> void:
	lock_animation = false


func save() -> Dictionary:
	return {
		"file_id": "player_rqXkdk",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"node_name": name,
	}


func connect_camera(cam: Camera2D) -> void:
	cam_remote.remote_path = cam.get_path()


func _input(_event) -> void:
	if Input.is_action_pressed("interact"):
		interact()


func interact() -> void:
	face("interact")
	action_radius.act_on_closest_actable("interact")


func mine() -> void:
	action_radius.act_on_closest_actable("mine")


func _on_attack_impact() -> void:
	mine()


func face(method_name: String) -> void:
	var closest_node = action_radius.get_closest_node(method_name)
	if closest_node:
		var dir = sign((closest_node.global_position - global_position).x)
		anim_tree["parameters/idle/blend_position"] = dir
		anim_tree["parameters/move/blend_position"] = dir
		anim_tree["parameters/attack/blend_position"] = dir
