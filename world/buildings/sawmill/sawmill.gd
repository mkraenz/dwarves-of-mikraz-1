extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio: AudioStreamPlayer2D = $Audio
@onready var production: Production = %Production
@onready var anims: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	production._refresh_mark()


func interact() -> void:
	production.interact()


func save() -> Dictionary:
	return {
		"file_id": "sawmill_DgFJ2E",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"production": production.save()
	}


func load_before_ready(save_dict: Dictionary) -> void:
	%Production.load_from(save_dict.production)


func _on_production_producing() -> void:
	sprite.modulate = Color.WHITE
	anims.play("producing")


func _on_production_blocked() -> void:
	sprite.modulate = Color(1, .5, .5)
	anims.play("idle")


func _on_production_pending() -> void:
	sprite.modulate = Color(1, 1, .5)
	anims.play("idle")


func _on_production_idle() -> void:
	sprite.modulate = Color.WHITE
	anims.play("idle")


func _on_production_outputting_products(_item_id: String, _amount: float) -> void:
	audio.play()


func _on_production_order_cancelled() -> void:
	_on_production_idle()
