extends Button


func refresh_text(crafted_amount: float) -> void:
	if crafted_amount == 0:
		text = "Craft Max"
	elif crafted_amount == INF:
		text = "Craft ∞"
	else:
		text = "Craft x%s" % [crafted_amount]
