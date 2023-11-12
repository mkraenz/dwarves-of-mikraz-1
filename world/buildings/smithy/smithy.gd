extends StaticBody2D

const Pickup = preload("res://world/pickup/pickup.tscn")

## TODO unify with other manifacturing buildings, particularly sawmill

@export var building_type = "smithy"
## type: Recipe
@export var ordered_recipe: Dictionary = {}
## for open-ended orders, set to INF
@export var ordered_batches: float = 0

var eventbus := Eventbus
var gdata := GData
var ginventory := GInventory
var gstate := GState

@onready var how_to_use := $HowToUse
@onready var current_order_display := $CurrentOrderDisplay
@onready var audio := $Audio
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var progressbar: TextureProgressBar = $Progressbar

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
		return has_an_order and (resources_in_use or needs_fulfilled_for_next_batch())


func _ready():
	eventbus.production_tick.connect(_on_production_tick)
	eventbus.ordered_at_workshop.connect(_on_ordered_at_workshop)


func _process(_delta):
	refresh_mark()


func _on_ordered_at_workshop(
	recipe: Dictionary, batches: float, at_target_node_path: String
) -> void:
	var order_is_for_this_workshop = str(get_path()) == at_target_node_path
	if order_is_for_this_workshop:
		if has_an_order:
			output_current_inputs()
			clear_order()
		ordered_recipe = recipe
		ordered_batches = batches
		printt("incoming order", batches, recipe)


func interact() -> void:
	eventbus.toggle_crafting_menu.emit(building_type, str(get_path()))


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


func finish_current_batch() -> void:
	output_products()
	produced_batches += 1
	resources_in_use = []
	ticks_to_batch_completion = INF


func prepare_next_batch() -> void:
	if needs_fulfilled_for_next_batch():
		consume_resources()
		ticks_to_batch_completion = ordered_recipe.duration_in_ticks
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


func output_current_inputs() -> void:
	for resource in resources_in_use:
		var amount = resource.amount
		var item_id = resource.id
		_output_pickups(item_id, amount)
	resources_in_use = []


func clear_order() -> void:
	ordered_batches = 0
	ordered_recipe = {}
	produced_batches = 0
	ticks_to_batch_completion = INF
	resources_in_use = []


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


func refresh_mark() -> void:
	refresh_current_order_display()

	if is_producing:
		return mark_as_producing()
	elif has_an_order and not is_pending:
		return mark_as_production_blocked()
	elif is_pending:
		return mark_as_pending()
	return mark_as_idle()


func refresh_current_order_display() -> void:
	if has_an_order:
		current_order_display.show()
		current_order_display.set_icon_texture(gdata.get_item_icon(ordered_recipe.item_id))
		var remaining_amount = (ordered_batches - produced_batches) * ordered_recipe.batch_size
		current_order_display.set_text(remaining_amount)
	else:
		current_order_display.hide()


func mark_as_producing() -> void:
	progressbar.show()
	progressbar.max_value = ordered_recipe.duration_in_ticks
	progressbar.value = ordered_recipe.duration_in_ticks - ticks_to_batch_completion
	anim_sprite.modulate = Color.GREEN
	if has_method("animate_mark_as_producing"):
		animate_mark_as_producing()


func mark_as_production_blocked() -> void:
	progressbar.hide()
	anim_sprite.modulate = Color.RED
	if has_method("animate_mark_as_blocked"):
		animate_mark_as_blocked()


func mark_as_pending() -> void:
	progressbar.hide()
	anim_sprite.modulate = Color.YELLOW
	if has_method("animate_mark_as_pending"):
		animate_mark_as_pending()


func mark_as_idle() -> void:
	progressbar.hide()
	anim_sprite.modulate = Color.WHITE
	if has_method("animate_mark_as_idle"):
		animate_mark_as_idle()


func output_products() -> void:
	var amount = ordered_recipe.batch_size
	var item_id = ordered_recipe.item_id
	_output_pickups(item_id, amount)
	audio.play()


func _output_pickups(item_id: String, amount: int) -> void:
	const y := 25
	const CENTER_OFFSET = 10
	for i in range(amount):
		var x = lerp(-CENTER_OFFSET, CENTER_OFFSET, float(i) / (amount - 1)) if amount != 1 else 0
		var instance = Pickup.instantiate()
		instance.global_position = global_position + Vector2(x, y)
		instance.item_id = item_id
		get_parent().add_child(instance)


func animate_mark_as_producing() -> void:
	anim_sprite.play("producing")


func animate_mark_as_blocked() -> void:
	animate_mark_as_idle()


func animate_mark_as_idle() -> void:
	anim_sprite.play("idle")


func animate_mark_as_pending() -> void:
	animate_mark_as_idle()
