extends OptionButton

var locale_in_that_language = {
	"en": "English",
	"de": "Deutsch",
}


func _ready() -> void:
	var locales := TranslationServer.get_loaded_locales()
	var current_locale := TranslationServer.get_locale()
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


func _on_item_selected(index: int) -> void:
	var locale = get_item_metadata(index)
	LocaleSwitcher.change_locale(locale)
