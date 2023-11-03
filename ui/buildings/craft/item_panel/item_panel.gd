extends ColorRect

@export var recipe: Dictionary

var gdata := GData
@onready var label = $H/Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var crafted_item = gdata.items[recipe.id]
	label.text = crafted_item.label
