extends TextureProgressBar

@export var production: Production

func _ready():
	assert(production, "Missing production on %s in parent %s" % [name, get_parent().name])

	production.producing.connect(func(): 
		max_value = production.ordered_recipe.duration_in_ticks
		value = production.ordered_recipe.duration_in_ticks - production.ticks_to_batch_completion
		show()
	)
	production.blocked.connect(hide)
	production.pending.connect(hide)
	production.idle.connect(hide)
