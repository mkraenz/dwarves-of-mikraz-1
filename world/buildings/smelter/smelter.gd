extends StaticBody2D

@onready var audio := $Audio
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var production := $Production


func interact() -> void:
	production.interact()


func save() -> Dictionary:
	return {
		"file_id": "smelter_mx3GEc",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"production": production.save(),
	}


func load_before_ready(save_dict: Dictionary) -> void:
	$Production.load_from(save_dict.production)


func on_production_producing() -> void:
	sprite.modulate = Color.WHITE
	sprite.play("producing")


func on_production_blocked() -> void:
	sprite.modulate = Color(1, .5, .5)
	sprite.play("idle")


func on_production_pending() -> void:
	sprite.modulate = Color(1, 1, .5)
	sprite.play("idle")


func on_production_idle() -> void:
	sprite.modulate = Color.WHITE
	sprite.play("idle")


func on_output_products() -> void:
	audio.play()
