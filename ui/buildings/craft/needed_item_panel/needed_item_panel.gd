extends MarginContainer

@export var in_stock := 0
@export var needed := 1
@export var item_name := "Need 1"
@export var item_texture: Texture2D

@onready var amounts_label := $V/Amounts
@onready var name_label := $V/Name
@onready var icon := $V/Icon


func refresh() -> void:
	amounts_label.text = "%s/%s" % [in_stock, needed]
	name_label.text = item_name
	if item_texture:
		icon.texture = item_texture

	if in_stock > needed:
		undim()
	else:
		dim()


func undim() -> void:
	var default_modulate = Color.WHITE
	amounts_label.modulate = default_modulate
	name_label.modulate.a = default_modulate


func dim() -> void:
	var dimmed_modulate = Color(0.7, 0.7, 0.7)
	amounts_label.modulate = dimmed_modulate
	name_label.modulate = dimmed_modulate
