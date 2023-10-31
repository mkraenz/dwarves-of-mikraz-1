extends Node

signal show_textbox(options: Array)
signal textbox_hidden
signal close_textbox
signal hit_it
signal hit_it_harder
signal add_to_inventory(resource_name: String, amount: int)
signal new_game_pressed
signal load_game_pressed
## loads the most recent save game
signal load_most_recent_game_pressed
signal resume_game_pressed
signal quit_to_title_pressed
