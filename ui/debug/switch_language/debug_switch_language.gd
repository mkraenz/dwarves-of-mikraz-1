extends Button


func _ready():
	if not FeatureFlags.debug:
		hide()
	else:
		_on_pressed()


func _on_pressed() -> void:
	var locales := TranslationServer.get_loaded_locales()
	var i := locales.find(TranslationServer.get_locale())
	var locale = locales[(i + 1) % len(locales)]
	TranslationServer.set_locale(locale)
	text = "Debug: {locale}".format({locale = TranslationServer.get_locale_name(locale)})
