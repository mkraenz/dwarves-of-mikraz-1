extends Node2D

@export var production: Production
@export var display: CurrentOrderDisplay

var gdata := GData


func _ready():
	production.idle.connect(handle_production_update)
	production.pending.connect(handle_production_update)
	production.blocked.connect(handle_production_update)
	production.producing.connect(handle_production_update)
	production.order_received.connect(handle_production_update)
	production.order_cancelled.connect(handle_production_update)
	production.loading_finished.connect(handle_production_update)


func handle_production_update():
	if production.has_an_order:
		var item_id = production.ordered_recipe.item_id
		display.set_icon_texture(gdata.get_item_icon(item_id))
		display.set_text(production.remaining_amount_of_current_order)
		display.show()
	else:
		display.hide()
