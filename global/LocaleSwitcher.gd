extends Node
## Wrapper around translation server so we can listen for locale changes via signal.
# See https://www.reddit.com/r/godot/comments/qrccck/localization_and_dynamic_text/ for the problem and the idea of this solution.
# In our case, the craft_button did not update.

var eventbus := Eventbus


func change_locale(locale: String):
	TranslationServer.set_locale(locale)
	eventbus.locale_changed.emit()
