extends StaticBody2D

@onready var audio := $Audio
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bellows: AnimatedSprite2D = $Bellows
@onready var shape1: CollisionShape2D = $Shape
@onready var shape2: CollisionShape2D = $Shape2
@onready var shape3: CollisionShape2D = $Shape3
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
	anim_sprite.modulate = Color.WHITE
	anim_sprite.play("producing")
	bellows.play("producing")


func on_production_blocked() -> void:
	anim_sprite.modulate = Color(1, .5, .5)
	anim_sprite.play("idle")
	bellows.play("idle")


func on_production_pending() -> void:
	anim_sprite.modulate = Color(1, 1, .5)
	anim_sprite.play("idle")
	bellows.play("idle")


func on_production_idle() -> void:
	anim_sprite.modulate = Color.WHITE
	anim_sprite.play("idle")
	bellows.play("idle")


func on_output_products() -> void:
	audio.play()


func set_collision_scale(new_scale: float) -> void:
	for shape in [shape1, shape2, shape3]:
		shape.scale = Vector2.ONE * new_scale
