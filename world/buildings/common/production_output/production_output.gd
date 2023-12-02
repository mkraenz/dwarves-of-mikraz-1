extends Node2D

@export var production: Production
@export var spot: ProductionOutputSpot


func _ready():
	production.outputting_input.connect(_on_output)
	production.outputting_products.connect(_on_output)


func _on_output(item_id: String, amount: int) -> void:
	spot.spawn(item_id, amount)
