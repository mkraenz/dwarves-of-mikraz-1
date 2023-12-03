extends GutTest

const Production = preload("res://world/buildings/common/production/production.tscn")
var prod: Production

var recipe: Dictionary


func before_each() -> void:
	recipe = {
		"id": "planks",
		"item_id": "plank",
		"needs": [{"id": "log", "amount": 1}],
		"batch_size": 2,
		"duration_in_ticks": 5
	}
	prod = add_child_autofree(Production.instantiate())


func test_has_no_order_by_default():
	assert_eq(prod.has_an_order, false)


func test_sets_ticks_when_order_placed():
	prod.ordered_recipe = recipe
	prod.ordered_batches = 1
	GInventory._on_add_to_inventory("log", 15)  # setup the needs

	prod._on_production_tick()

	assert_lt(prod.ticks_to_batch_completion, INF)
	assert_eq(prod.ticks_to_batch_completion, 5.0)


func test_ginventory_keeps_its_state():
	assert_true(GInventory.has("log", 14))


func test_cancelling_an_order_in_progress_clears_the_order():
	prod.ordered_recipe = recipe
	prod.ordered_batches = 1
	GInventory._on_add_to_inventory("log", 1)
	prod._on_production_tick()

	Eventbus.cancel_order_at_workshop.emit(prod.get_path())

	assert_false(prod.has_an_order)
	assert_eq_deep(prod.ordered_recipe, {})
	assert_eq(prod.ordered_batches, 0.0)
	assert_eq(prod.ticks_to_batch_completion, INF)


func test_on_cancelling_an_order_it_outputs_the_inputs():
	watch_signals(prod)
	prod.ordered_recipe = {
		"id": "planks",
		"item_id": "plank",
		"needs": [{"id": "log", "amount": 1}, {"id": "iron_ore", "amount": 5}],
		"batch_size": 2,
		"duration_in_ticks": 5
	}
	prod.ordered_batches = 1
	GInventory._on_add_to_inventory("log", 1)
	GInventory._on_add_to_inventory("iron_ore", 5)
	prod._on_production_tick()
	assert_eq(prod.resources_in_use, [{"id": "log", "amount": 1}, {"id": "iron_ore", "amount": 5}])

	Eventbus.cancel_order_at_workshop.emit(prod.get_path())

	assert_signal_emitted_with_parameters(prod, "outputting_input", ["log", 1], 0)
	assert_signal_emitted_with_parameters(prod, "outputting_input", ["iron_ore", 5], 1)


func test_interact_calls_crafting_menu():
	watch_signals(Eventbus)
	prod.building_type = "sawmill"

	prod.interact()

	assert_signal_emitted_with_parameters(
		Eventbus, "toggle_crafting_menu", ["sawmill", str(prod.get_path())]
	)


func test_sets_an_order_when_ordered_at_this_workshop():
	Eventbus.ordered_at_workshop.emit(recipe, 5, prod.get_path())

	assert_true(prod.has_an_order)


func test_ignores_order_when_ordered_at_another_workshop():
	Eventbus.ordered_at_workshop.emit(recipe, 5, "/root/definitely-not-the-right-path")

	assert_false(prod.has_an_order)
