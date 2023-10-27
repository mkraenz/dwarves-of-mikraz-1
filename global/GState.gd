extends Node

@export var textbox_open := false  # decides whether to use textbox input or player input

var eventbus := Eventbus

var interactions = {
	"tv-from-left":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause just so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-right":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause just so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-up":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause just so much trouble?",
		"options":
		[
			{"label": "Hit it", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-from-down":
	{
		"label":
		"Darn that old TV. It's malfunctioning again!? How can one small apparatus cause just so much trouble?",
		"options":
		[
			{"label": "Hit it.", "event_name_on_selected": "hit_it"},
			{"label": "Hit it harder!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-after-hard-hit":
	{
		"label": "Letting off some steam, huh? ",
		"options":
		[
			{"label": "Hit again.", "event_name_on_selected": "hit_it"},
			{"label": "Hit it 9000 times!", "event_name_on_selected": "hit_it_harder"},
		],
	},
	"tv-hitting-worked":
	{
		"label": "It's working again! Nice.",
		"options":
		[
			{"label": "Let's head back to the sofa.", "event_name_on_selected": "close_textbox"},
			{
				"label": "Quit with a feeling of accomplishment",
				"event_name_on_selected": "close_textbox"
			},
			{
				"label": "Thanks for playing! Huh, who am I even talking to?",
				"event_name_on_selected": "close_textbox"
			},
		],
	},
	"sofa":
	{
		"label": "Oh, my trusty sofa. You never malfunction, do you?",
		"options":
		[
			{"label": "Sit down.", "event_name_on_selected": "close_textbox"},
			{"label": "Sit down. Resignate.", "event_name_on_selected": "close_textbox"},
		],
	},
}


func _ready():
	eventbus.connect("textbox_hidden", on_textbox_closed)


func open_textbox(interaction_key: String) -> void:
	textbox_open = true
	eventbus.show_textbox.emit(interactions[interaction_key])


func on_textbox_closed() -> void:
	textbox_open = false
