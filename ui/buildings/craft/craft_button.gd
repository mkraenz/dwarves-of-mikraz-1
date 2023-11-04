extends Button


func refresh_text(crafted_amount: int) -> void:
	if crafted_amount == 0:
		text = "Craft Max"
	elif crafted_amount < 0:
		text = "Craft ∞"
	else:
		text = "Craft x%s" % [crafted_amount]
