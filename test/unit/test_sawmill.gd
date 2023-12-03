extends GutTest

const Sawmill = preload("res://world/buildings/sawmill/sawmill.tscn")

var sawmill
var recipe: Dictionary


func before_each() -> void:
	recipe = {
		"id": "planks",
		"item_id": "plank",
		"needs": [{"id": "log", "amount": 1}],
		"batch_size": 2,
		"duration_in_ticks": 5
	}
	sawmill = add_child_autofree(Sawmill.instantiate())


func test_hides_progressbar_and_order_display_and_animate_idle_by_default():
	var progressbar = sawmill.get_node("Producer/Progressbar")
	var order_display = sawmill.get_node("Producer/CurrentOrderDisplay")
	var anims = sawmill.get_node("AnimationPlayer") as AnimationPlayer

	assert_false(progressbar.visible, "Progressbar should be hidden by default")
	assert_false(order_display.visible, "CurrentOrderDisplay should be hidden by default")
	assert_eq(anims.current_animation, "idle", "Should animate as idle")


func test_on_producing_order_shows_the_progressbar_and_order_display_and_animates():
	var prod = sawmill.get_node("Producer/Production") as Production
	var progressbar = sawmill.get_node("Producer/Progressbar")
	var order_display = sawmill.get_node("Producer/CurrentOrderDisplay")
	var anims = sawmill.get_node("AnimationPlayer") as AnimationPlayer
	Eventbus.ordered_at_workshop.emit(recipe, 5, prod.get_path())

	Eventbus.production_tick.emit()

	assert_true(progressbar.visible, "Progressbar should be visible when producing")
	assert_true(order_display.visible, "CurrentOrderDisplay should be visible when producing")
	assert_eq(anims.current_animation, "producing", "Should animate as producing")


func test_on_cancelling_an_order_hides_the_progressbar_and_order_display_and_stops_animating():
	var prod = sawmill.get_node("Producer/Production") as Production
	var progressbar = sawmill.get_node("Producer/Progressbar")
	var order_display = sawmill.get_node("Producer/CurrentOrderDisplay")
	var anims = sawmill.get_node("AnimationPlayer") as AnimationPlayer
	Eventbus.ordered_at_workshop.emit(recipe, 5, prod.get_path())
	Eventbus.production_tick.emit()

	Eventbus.cancel_order_at_workshop.emit(prod.get_path())

	assert_not_null(progressbar, "Progressbar should be defined after cancelling a producing order")
	assert_false(progressbar.visible, "Progressbar should be hidden")
	assert_false(order_display.visible, "CurrentOrderDisplay should be hidden")
	assert_eq(anims.current_animation, "idle", "Should animate as idle")
