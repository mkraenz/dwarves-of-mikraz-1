extends StaticBody2D

@export var interactable := true
## type: Recipe
@export var ordered_recipe: Dictionary = {}
## for open-ended orders, set to INF
@export var ordered_batches: float = 0

var eventbus := Eventbus
var gdata := GData
var ginventory := GInventory

@onready var how_to_use := $HowToUse

var ticks_to_batch_completion = INF
var produced_batches: int = 0
## type: NeededItem[]
var resources_in_use := []

var is_producing := false:
	get:
		return ticks_to_batch_completion != INF

var has_an_order := false:
	get:
		return ordered_recipe != {}

var order_filled := true:
	get:
		return produced_batches >= ordered_batches

var batch_finished := true:
	get:
		return ticks_to_batch_completion <= 0


func _ready():
	eventbus.production_tick.connect(_on_production_tick)
	eventbus.ordered_at_workshop.connect(_on_ordered_at_workshop)


func _on_ordered_at_workshop(
	recipe: Dictionary, batches: float, at_target_node_path: String
) -> void:
	var order_is_for_this_workshop = str(get_path()) == at_target_node_path
	if order_is_for_this_workshop:
		clear_order()
		ordered_recipe = recipe
		ordered_batches = batches
		prints("incoming order", batches, recipe)


func interact() -> void:
	eventbus.toggle_crafting_menu.emit("sawmill", str(get_path()))


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	how_to_use.hide()


## IMPORTANT: order of steps is relevant since they all change state
func _on_production_tick() -> void:
	ticks_to_batch_completion -= 1

	if not has_an_order:
		return

	if batch_finished:
		finish_current_batch()

	if order_filled:
		clear_order()

	if has_an_order and not is_producing:
		prepare_next_batch()

	if not has_an_order:
		mark_as_pending()


func finish_current_batch() -> void:
	output_product()
	produced_batches += 1
	resources_in_use = []
	ticks_to_batch_completion = INF


func prepare_next_batch() -> void:
	if needs_fulfilled_for_next_batch():
		consume_resources()
		ticks_to_batch_completion = ordered_recipe.durationInTicks
		mark_as_producing()
	else:
		mark_as_production_blocked()


func needs_fulfilled_for_next_batch() -> bool:
	var need_fulfilled = func(need): return ginventory.has(need.id, need.amount)
	return ordered_recipe.needs.all(need_fulfilled)


func consume_resources() -> void:
	for need in ordered_recipe.needs:
		eventbus.add_to_inventory.emit(need.id, -need.amount)
		resources_in_use = ordered_recipe.needs


func clear_order() -> void:
	ordered_batches = 0
	ordered_recipe = {}
	produced_batches = 0
	ticks_to_batch_completion = INF


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
		"ordered_batches": JSONX.stringify_float(ordered_batches),
		"produced_batches": produced_batches,
		"ticks_to_batch_completion": JSONX.stringify_float(ticks_to_batch_completion),
		"resources_in_use": resources_in_use,
	}
	return save_dict


func mark_as_producing() -> void:
	modulate = Color.GREEN


func mark_as_production_blocked() -> void:
	modulate = Color.RED


func mark_as_pending() -> void:
	modulate = Color.WHITE
