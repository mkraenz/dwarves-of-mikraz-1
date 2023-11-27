extends OptionButton

var app_config := AppConfig

var locale_in_that_language = {
	"en": "English",
	"de": "Deutsch",
}


func _ready() -> void:
	var locales := TranslationServer.get_loaded_locales()
	var current_locale = TranslationServer.get_locale().substr(0, 2)
	for i in len(locales):
		var locale = locales[i]
		var locale_in_english := TranslationServer.get_locale_name(locale)
		var translated_locale = locale_in_that_language.get(locale)
		if translated_locale:
			add_item(
				"{translated_locale} ({locale_in_english})".format(
					{"locale_in_english": locale_in_english, "translated_locale": translated_locale}
				)
			)

		else:
			add_item(locale_in_english)
		set_item_metadata(i, locale)

		if current_locale == locale.substr(0, 2):
			selected = i


func _on_item_selected(index: int) -> void:
	var locale = get_item_metadata(index)
	app_config.change_locale(locale)
