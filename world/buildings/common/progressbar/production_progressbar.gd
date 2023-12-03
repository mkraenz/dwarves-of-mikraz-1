extends TextureProgressBar

@export var production: Production

func _ready():
	production.producing.connect(func(): 
		max_value = production.ordered_recipe.duration_in_ticks
		value = production.ordered_recipe.duration_in_ticks - production.ticks_to_batch_completion
		show()
	)
	production.blocked.connect(hide)
	production.pending.connect(hide)
	production.idle.connect(hide)
	production.order_cancelled.connect(hide)
