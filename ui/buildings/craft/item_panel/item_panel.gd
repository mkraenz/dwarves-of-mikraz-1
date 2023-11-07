extends Button

signal selected(item_id: String)

@export var recipe: Dictionary

var gdata := GData
var eventbus := Eventbus
var ginventory := GInventory


# Called when the node enters the scene tree for the first time.
func _ready():
	var crafted_item: Dictionary = gdata.items[recipe.id]
	print(crafted_item)
	var _icon = crafted_item.get("icon")
	if _icon:
		match _icon.type:
			"Texture2D":
				var texture: CompressedTexture2D = load(_icon.resPath)
				icon = texture
			"AtlasTexture":
				pass
			_:
				printt("ERROR: unsupported texture type in", name)
	text = crafted_item.label


func _gui_input(_event):
	if Input.is_action_just_pressed("act"):
		selected.emit(recipe.id)
