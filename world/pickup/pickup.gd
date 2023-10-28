extends Node2D

@export var type: String
@export var amount: int = 1
@export var SUCKING_SPEED := 100.0
@export var TOLERANCE := 5
@onready var eventbus := Eventbus
@onready var inventory := GInventory

var get_sucked_towards_global_pos := Vector2.ZERO


func _ready():
	assert(type, "Pickup has no type. Set it via export variable.")
	assert(type in inventory.inventory, "Pickup's type does not exist in GInventory")


func _process(delta):
	if get_sucked_towards_global_pos != Vector2.ZERO:
		global_position = global_position.move_toward(
			get_sucked_towards_global_pos, delta * SUCKING_SPEED
		)
		if Vector2(get_sucked_towards_global_pos - global_position).length() < TOLERANCE:
			collect()


func unsuck() -> void:
	get_sucked_towards_global_pos = Vector2.ZERO


func collect() -> void:
	eventbus.add_to_inventory.emit(type, amount)
	queue_free()
