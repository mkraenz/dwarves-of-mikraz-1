extends StaticBody2D

@onready var audio := $Audio
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shape: CollisionShape2D = $Shape
@onready var production := $Production


func interact() -> void:
	production.interact()


func save() -> Dictionary:
	var save_dict = {
		"file_id": "smithy_2IVp6B",
		"parent": get_parent().get_path(),
		"pos_x": position.x,  # Vector2 is not supported by JSON
		"pos_y": position.y,
		"production": production.save(),
	}
	return save_dict


func load_before_ready(save_dict: Dictionary) -> void:
	$Production.load_from(save_dict.production)


func on_production_producing() -> void:
	anim_sprite.modulate = Color.GREEN
	anim_sprite.play("producing")


func on_production_blocked() -> void:
	anim_sprite.modulate = Color.RED
	anim_sprite.play("idle")


func on_production_pending() -> void:
	anim_sprite.modulate = Color.YELLOW
	anim_sprite.play("idle")


func on_production_idle() -> void:
	anim_sprite.modulate = Color.WHITE
	anim_sprite.play("idle")


func on_output_products() -> void:
	audio.play()


func set_collision_scale(new_scale: float) -> void:
	shape.scale = Vector2.ONE * new_scale
