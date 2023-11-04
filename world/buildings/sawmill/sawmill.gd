extends StaticBody2D

@export var interactable := true
@export var ordered_recipe: Dictionary = {}
@export var ordered_batches := 0

var eventbus := Eventbus
var gdata := GData
var ginventory := GInventory

@onready var how_to_use := $HowToUse

var ticks_to_batch_completion = INF


func _ready():
	eventbus.production_tick.connect(_on_production_tick)


func interact() -> void:
	eventbus.toggle_crafting_menu.emit("sawmill")


func mark() -> void:
	how_to_use.show()


func unmark() -> void:
	how_to_use.hide()


func _on_production_tick() -> void:
	ticks_to_batch_completion -= 1
	var batch_finished = ticks_to_batch_completion <= 0
	if ordered_recipe and batch_finished:
		output_product()
		ordered_batches -= 1

		var ordered_filled = ordered_batches <= 0
		if ordered_filled:
			reset()
		else:
			prepare_next_batch()

	## TODO #1 remove
	# if not ordered_recipe:
	# 	prints("demoing an order")
	# 	ordered_recipe = gdata.crafting_recipes["sawmill"][0]
	# 	ticks_to_batch_completion = ordered_recipe.durationInTicks
	# 	ordered_batches = 3


func prepare_next_batch() -> void:
	ticks_to_batch_completion = ordered_recipe.durationInTicks


func reset() -> void:
	ticks_to_batch_completion = INF
	ordered_batches = 0
	ordered_recipe = {}


func output_product() -> void:
	## TODO #1 this should actually spawn objects in the world to be collected
	eventbus.add_to_inventory.emit(ordered_recipe.id, ordered_recipe.outputAmount)
