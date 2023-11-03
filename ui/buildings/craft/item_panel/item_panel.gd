extends ColorRect

@export var recipe: Dictionary

var gdata := GData
var eventbus := Eventbus
@onready var label = $H/Label

var ginventory := GInventory


# Called when the node enters the scene tree for the first time.
func _ready():
	var crafted_item: Dictionary = gdata.items[recipe.id]
	label.text = crafted_item.label


func _gui_input(_event):
	if Input.is_action_just_pressed("act"):
		## TODO #1
		eventbus.add_to_inventory.emit(recipe.id, recipe.outputAmount)
		for needed_item in recipe.needs:
			eventbus.add_to_inventory.emit(needed_item.id, -needed_item.amount)
		eventbus.close_crafting_menu.emit()
