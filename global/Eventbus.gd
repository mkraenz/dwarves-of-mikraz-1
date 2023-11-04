extends Node

signal add_to_inventory(resource_name: String, amount: int)
signal production_tick  # production buildings connect to this signal and reduce their order's durationInTicks counter by 1

# menus and persistence
signal new_game_pressed
signal load_game_pressed
signal load_most_recent_game_pressed
signal resume_game_pressed
signal quit_to_title_pressed
signal save_game_pressed
signal game_saved_successfully
signal toggle_crafting_menu(for_building: String)
signal close_crafting_menu
