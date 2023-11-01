extends CharacterBody2D
class_name Player

@export var speed = 150

@onready var gstate := GState
@onready var audio_anims := $AnimationPlayer
@onready var anim_tree: AnimationTree = $AnimationTree

var lock_animation = false


func _ready():
	anim_tree.active = true


func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()
	update_anim_params()


func update_anim_params() -> void:
	var rel_mouse_pos = get_global_mouse_position() - global_position
	anim_tree["parameters/idle/blend_position"] = rel_mouse_pos.x
	anim_tree["parameters/move/blend_position"] = rel_mouse_pos.x
	if not lock_animation:  # without this lock, when attacking and wiggling with the mouse around the player from left to right, the attack wiggles between attack_left and attack_right, never actually swinging the axe
		anim_tree["parameters/attack/blend_position"] = rel_mouse_pos.x

	if velocity == Vector2.ZERO:
		anim_tree["parameters/conditions/idle"] = true
		anim_tree["parameters/conditions/is_moving"] = false
	else:
		anim_tree["parameters/conditions/idle"] = false
		anim_tree["parameters/conditions/is_moving"] = true

	if Input.is_action_pressed("act"):
		anim_tree["parameters/conditions/attack"] = true
	else:
		anim_tree["parameters/conditions/attack"] = false


func _locked_anim_started() -> void:
	lock_animation = true


func _locked_anim_finished() -> void:
	lock_animation = false


func save() -> Dictionary:
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
	}
	return save_dict
