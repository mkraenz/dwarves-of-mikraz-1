extends Button


func refresh_text(crafted_amount: float) -> void:
	if crafted_amount == 0:
		text = tr("Craft {amount}").format({amount = "Max"})
	elif crafted_amount == INF:
		text = tr("Craft {amount}").format({amount = "∞"})
	else:
		text = tr("Craft x{amount}").format({amount = crafted_amount})
