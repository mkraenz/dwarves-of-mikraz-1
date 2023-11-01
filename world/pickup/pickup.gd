extends Area2D

@export var type: String
@export var amount: int = 1
@export var SUCKING_SPEED := 100.0
@export var TOLERANCE := 5
@onready var eventbus := Eventbus
@onready var inventory := GInventory
@onready var audio := $Audio

var get_sucked_towards_global_pos := Vector2.ZERO
var suckable = false


func _ready():
	assert(type, "Pickup has no type. Set it via export variable.")
	assert(type in inventory.inventory, "Pickup's type does not exist in GInventory")


func _process(delta):
	if not suckable:
		return
	if get_sucked_towards_global_pos != Vector2.ZERO:
		global_position = global_position.move_toward(
			get_sucked_towards_global_pos, delta * SUCKING_SPEED
		)
		if Vector2(get_sucked_towards_global_pos - global_position).length() < TOLERANCE:
			die()


func unsuck() -> void:
	get_sucked_towards_global_pos = Vector2.ZERO


func die() -> void:
	eventbus.add_to_inventory.emit(type, amount)
	hide()
	set_process(false)
	monitorable = false
	audio.play()
	await audio.finished

	queue_free()


func _on_suck_cooldown_timeout():
	suckable = true


func save() -> Dictionary:
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
	}
	return save_dict
