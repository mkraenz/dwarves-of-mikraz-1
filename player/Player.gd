extends CharacterBody2D
class_name Player

@export var speed = 200

@onready var gstate := GState
@onready var audio_anims := $AnimationPlayer


func get_input() -> void:
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed


func _physics_process(_delta) -> void:
	get_input()
	move_and_slide()
