extends GutTest

const Production = preload("res://world/buildings/common/production/production.gd")
var prod: Production


func before_each() -> void:
	prod = Production.new()


func after_each() -> void:
	prod.free()


func test_has_no_order_by_default():
	assert_eq(prod.has_an_order, false)


func test_sets_ticks_when_order_placed():
	prod.ordered_recipe = {
		"id": "planks",
		"item_id": "plank",
		"needs": [{"id": "log", "amount": 1}],
		"batch_size": 2,
		"duration_in_ticks": 5
	}
	prod.ordered_batches = 1
	GInventory._on_add_to_inventory("log", 15)  # setup the needs

	assert_true(prod.has_an_order)
	prod._on_production_tick()

	assert_lt(prod.ticks_to_batch_completion, INF)
	assert_eq(prod.ticks_to_batch_completion, 5.0)


func test_ginventory_keeps_its_state():
	assert_true(GInventory.has("log", 14))
