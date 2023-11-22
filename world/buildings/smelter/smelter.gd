extends StaticBody2D

@onready var audio := $Audio
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shape1: CollisionShape2D = $Shape
@onready var shape2: CollisionShape2D = $Shape2
@onready var shape3: CollisionShape2D = $Shape3
@onready var shape4: CollisionShape2D = $Shape4
@onready var production := $Production


func interact() -> void:
	production.interact()


func save() -> Dictionary:
	var save_dict = {
		"file_id": "smelter_mx3GEc",
		"parent": get_parent().get_path(),
		"pos_x": position.x,
		"pos_y": position.y,
		"production": production.save(),
	}
	return save_dict


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


func set_collision_scale(new_scale: float) -> void:
	for shape in [shape1, shape2, shape3, shape4]:
		shape.scale = Vector2.ONE * new_scale
