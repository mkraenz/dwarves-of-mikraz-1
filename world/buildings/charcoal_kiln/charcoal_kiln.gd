extends StaticBody2D

@onready var audio: AudioStreamPlayer2D = $Audio
@onready var sprite: Sprite2D = $Sprite2D
@onready var production: Production = %Production


func interact() -> void:
	production.interact()


func save() -> Dictionary:
	return {
		"file_id": "charcoal_kiln_gbuAXz",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"production": production.save(),
	}


func load_before_ready(save_dict: Dictionary) -> void:
	%Production.load_from(save_dict.production)


func _on_production_producing() -> void:
	sprite.modulate = Color.GREEN


func _on_production_blocked() -> void:
	sprite.modulate = Color.RED


func _on_production_pending() -> void:
	sprite.modulate = Color.YELLOW


func _on_production_idle() -> void:
	sprite.modulate = Color.WHITE


func _on_production_outputting_products(_item_id: String, _amount: float) -> void:
	audio.play()
