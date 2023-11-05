extends StaticBody2D

@export var interactable := true
@export var ordered_recipe: Dictionary = {}  # type: Recipe ## TODO think about making Recipe a class with (static?) constructor receiving a Dictionary.
## for open-ended orders, set to INF
@export var ordered_batches: float = 0

var eventbus := Eventbus
var gdata := GData
var ginventory := GInventory

@onready var how_to_use := $HowToUse

var ticks_to_batch_completion = INF
var resources_in_use := []  # type: NeededItem[]
var is_producing := false:
	get:
		return ticks_to_batch_completion != INF
var has_an_order := false:
	get:
		return ordered_recipe != {}


func _ready():
	eventbus.production_tick.connect(_on_production_tick)
	eventbus.ordered_at_workshop.connect(_on_ordered_at_workshop)


func _on_ordered_at_workshop(
	recipe: Dictionary, batches: float, at_target_node_path: String
) -> void:
	if str(get_path()) == at_target_node_path:
		ordered_recipe = recipe
		ordered_batches = batches


func interact() -> void:
	eventbus.toggle_crafting_menu.emit("sawmill", str(get_path()))


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	how_to_use.hide()


func _on_production_tick() -> void:
	ticks_to_batch_completion -= 1
	var batch_finished = ticks_to_batch_completion <= 0

	# IMPORTANT: order of steps is relevant since they all change state
	if not has_an_order:
		return

	if batch_finished:
		finish_current_batch()

	var order_filled = ordered_batches <= 0
	if order_filled:
		finish_current_order()

	if has_an_order and not is_producing:
		prepare_next_batch()


func finish_current_batch() -> void:
	output_product()
	ordered_batches -= 1
	resources_in_use = []


func prepare_next_batch() -> void:
	if needs_fulfilled():
		consume_resources()
		ticks_to_batch_completion = ordered_recipe.durationInTicks
		mark_as_producing()
	else:
		mark_as_production_blocked()


func needs_fulfilled() -> bool:
	var need_fulfilled = func(need): return ginventory.has(need.id, need.amount)
	return ordered_recipe.needs.all(need_fulfilled)


func consume_resources() -> void:
	for need in ordered_recipe.needs:
		eventbus.add_to_inventory.emit(need.id, -need.amount)
		resources_in_use = ordered_recipe.needs


func finish_current_order() -> void:
	print("order finished")
	ticks_to_batch_completion = INF
	ordered_batches = 0
	ordered_recipe = {}


func output_product() -> void:
	## TODO #1 this should actually spawn objects in the world to be collected
	eventbus.add_to_inventory.emit(ordered_recipe.id, ordered_recipe.outputAmount)


func save() -> Dictionary:
	var save_dict = {
		"filename": get_scene_file_path(),
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"ordered_recipe": ordered_recipe,
		"ordered_batches": ordered_batches,
		"ticks_to_batch_completion": ticks_to_batch_completion,
		"resources_in_use": resources_in_use
	}
	return save_dict


func mark_as_producing() -> void:
	modulate = Color.WHITE


func mark_as_production_blocked() -> void:
	modulate = Color.DIM_GRAY
