extends StaticBody2D

@onready var how_to_interact := $HowToInteract
@onready var audio := $Audio
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shape: CollisionShape2D = $Shape
@onready var production := $Production


func interact() -> void:
	production.interact()


func mark() -> void:
	how_to_interact.show()


func unmark() -> void:
	how_to_interact.hide()


func save() -> Dictionary:
	var save_dict = {
		"file_id": "smelter_mx3GEc",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"production": production.save(),
	}
	return save_dict


func load_before_ready(save_dict: Dictionary) -> void:
	$Production.load_from(save_dict.production)


func on_production_producing() -> void:
	sprite.modulate = Color.GREEN
	sprite.play("producing")


func on_production_blocked() -> void:
	sprite.modulate = Color.RED
	sprite.play("idle")


func on_production_pending() -> void:
	sprite.modulate = Color.YELLOW
	sprite.play("idle")


func on_production_idle() -> void:
	sprite.modulate = Color.WHITE
	sprite.play("idle")


func on_output_products() -> void:
	audio.play()


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
