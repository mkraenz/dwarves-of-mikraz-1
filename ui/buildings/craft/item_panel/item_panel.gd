extends Button

signal selected(item_id: String)

@export var recipe: Dictionary

var gdata := GData
var eventbus := Eventbus
var ginventory := GInventory


# Called when the node enters the scene tree for the first time.
func _ready():
	icon = gdata.get_item_icon(recipe.item_id)
	text = gdata.get_localized_item_label(recipe.item_id)


func _gui_input(_event):
	if Input.is_action_just_pressed("act"):
		selected.emit(recipe.id)
