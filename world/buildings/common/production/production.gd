extends Node2D
class_name Production

signal producing
signal pending
signal blocked
signal idle
signal order_cancelled
signal order_received
signal outputting_products(item_id: String, amount: float)
signal outputting_input(item_id: String, amount: float)
signal loading_finished

## the thing that is producing. type: `{on_output_products: () => void; on_production_idle: () => void; on_production_producing: () => void; on_production_blocked: () => void; on_production_pending: () => void; get_path: () => void;}`
@export var production_site: Node2D
@export var current_order_display: Node2D
## type: keyof typeof buildingData
@export var building_type: String
## type: Recipe
@export var ordered_recipe: Dictionary = {}
## for open-ended orders, set to INF
@export var ordered_batches: float = 0

var eventbus := Eventbus
var gdata := GData
var ginventory := GInventory
var gstate := GState

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

var is_pending := true:
	get:
		return has_an_order and (resources_in_use or _needs_fulfilled_for_next_batch())


func _ready():
	eventbus.production_tick.connect(_on_production_tick)
	eventbus.ordered_at_workshop.connect(_on_ordered_at_workshop)
	eventbus.cancel_order_at_workshop.connect(_on_cancel_order_at_workshop)


func _process(_delta):
	_refresh_mark()


func _on_ordered_at_workshop(
	recipe: Dictionary, batches: float, at_target_node_path: String
) -> void:
	var order_is_for_this_workshop = str(production_site.get_path()) == at_target_node_path
	if order_is_for_this_workshop:
		if has_an_order:
			_output_current_inputs()
			clear_order()
			order_cancelled.emit()
		ordered_recipe = recipe
		ordered_batches = batches
		order_received.emit()


func _on_cancel_order_at_workshop(at_target_node_path: String) -> void:
	var targetted_at_this_workshop = str(production_site.get_path()) == at_target_node_path
	if targetted_at_this_workshop:
		_output_current_inputs()
		clear_order()
		order_cancelled.emit()


func interact() -> void:
	eventbus.toggle_crafting_menu.emit(building_type, str(production_site.get_path()))


func clear_order() -> void:
	ordered_batches = 0
	ordered_recipe = {}
	produced_batches = 0
	ticks_to_batch_completion = INF
	resources_in_use = []


## IMPORTANT: order of steps is relevant since they all change state
func _on_production_tick() -> void:
	ticks_to_batch_completion -= 1

	if not has_an_order:
		return

	if batch_finished:
		_finish_current_batch()

	if order_filled:
		clear_order()

	if has_an_order and not is_producing:
		_prepare_next_batch()


func _finish_current_batch() -> void:
	_output_products()
	produced_batches += 1
	resources_in_use = []
	ticks_to_batch_completion = INF


func _prepare_next_batch() -> void:
	if _needs_fulfilled_for_next_batch():
		_consume_resources()
		ticks_to_batch_completion = ordered_recipe.duration_in_ticks
		_mark_as_producing()
	else:
		_mark_as_production_blocked()


func _needs_fulfilled_for_next_batch() -> bool:
	return ginventory.satisfies_all_needs(ordered_recipe.needs)


func _consume_resources() -> void:
	for need in ordered_recipe.needs:
		eventbus.add_to_inventory.emit(need.id, -need.amount)
		resources_in_use = ordered_recipe.needs


func _output_current_inputs() -> void:
	for resource in resources_in_use:
		var amount = resource.amount
		var item_id = resource.id
		outputting_input.emit(item_id, amount)
	resources_in_use = []


func _refresh_mark() -> void:
	_refresh_current_order_display()

	if is_producing:
		return _mark_as_producing()
	elif has_an_order and not is_pending:
		return _mark_as_production_blocked()
	elif is_pending:
		return _mark_as_pending()
	return _mark_as_idle()


func _refresh_current_order_display() -> void:
	if has_an_order:
		current_order_display.show()
		current_order_display.set_icon_texture(gdata.get_item_icon(ordered_recipe.item_id))
		var remaining_amount = (ordered_batches - produced_batches) * ordered_recipe.batch_size
		current_order_display.set_text(remaining_amount)
	else:
		current_order_display.hide()


func _mark_as_producing() -> void:
	producing.emit()


func _mark_as_production_blocked() -> void:
	blocked.emit()


func _mark_as_pending() -> void:
	pending.emit()


func _mark_as_idle() -> void:
	idle.emit()


func _output_products() -> void:
	var amount = ordered_recipe.batch_size
	var item_id = ordered_recipe.item_id
	outputting_products.emit(item_id, amount)


func save() -> Dictionary:
	return {
		"ordered_recipe": ordered_recipe,
		"ordered_batches": JSONX.stringify_float(ordered_batches),
		"produced_batches": produced_batches,
		"ticks_to_batch_completion": JSONX.stringify_float(ticks_to_batch_completion),
		"resources_in_use": resources_in_use,
	}


func load_from(save_dict: Dictionary) -> void:
	for key in save_dict.keys():
		var val = save_dict[key]
		match typeof(val):
			TYPE_STRING:
				var value = JSONX.try_parse_infinity(val)
				self.set(key, value)
			_:
				self.set(key, val)
	loading_finished.emit()
