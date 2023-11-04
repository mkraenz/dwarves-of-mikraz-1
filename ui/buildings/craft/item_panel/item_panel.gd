extends ColorRect

signal selected(item_id: String)

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
		selected.emit(recipe.id)
