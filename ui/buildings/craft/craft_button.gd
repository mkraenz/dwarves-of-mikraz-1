extends Button

var crafted_amount: float = 1
var ordered_amount: float = 1


func _ready():
	Eventbus.locale_changed.connect(_on_locale_changed)


## Workaround: when changing the locale while this component is shown, it doesn't automatically call translate. Fortunately, if we are clever we rarely run into this issue as in-game menus should simply close, when we switch into the pause or title screens. On next open, they will just be refreshed anyway, including any language changes. As such, I will only leave this as a reference for how to do it, but with little intention to implement it anywhere else. See LocaleSwitcher for more details.
func _on_locale_changed() -> void:
	refresh_text(crafted_amount, ordered_amount)


func refresh_text(crafted_amount_: float, ordered_amount_: float) -> void:
	crafted_amount = crafted_amount_
	ordered_amount = ordered_amount_
	if crafted_amount == 0:
		text = tr("Craft {special_amount} ({total_amount}x)").format(
			{special_amount = "Max", total_amount = ordered_amount}
		)
	elif crafted_amount == INF:
		text = tr("Craft {special_amount}").format({special_amount = "∞"})
	else:
		text = tr("Craft x{amount}").format({amount = crafted_amount})
