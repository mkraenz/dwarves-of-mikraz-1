extends Area2D

@export var item_id: String
@export var amount: int = 1

@export var SUCKING_SPEED := 100.0
@export var TOLERANCE := 5

const ICON_SIZE_IN_PX := 16

@onready var eventbus := Eventbus
@onready var inventory := GInventory
@onready var audio := $Audio
@onready var icon := $Icon
var gdata := GData

var get_sucked_towards_global_pos := Vector2.ZERO
var suckable = false


func _ready():
	assert(item_id, "Pickup has no item_id. Set it via export variable.")
	assert(item_id in gdata.items, "Pickup's item_id does not exist in Gdata.items")

	icon.texture = gdata.get_item_icon(item_id)
	var icon_scale: float = float(ICON_SIZE_IN_PX) / icon.texture.get_width()
	icon.scale = Vector2(icon_scale, icon_scale)


func _physics_process(delta):
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
	eventbus.add_to_inventory.emit(item_id, amount)
	hide()
	set_physics_process(false)
	monitorable = false
	audio.play()
	await audio.finished

	queue_free()


func _on_suck_cooldown_timeout():
	suckable = true


func save() -> Dictionary:
	return {
		"file_id": "pickup_FUwDe7",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"item_id": item_id,
		"amount": amount,
	}
