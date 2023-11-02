extends Node

var bodies_in_player_action_radius: Array = []
var bodies_in_player_interaction_radius: Array = []


func reset() -> void:
	bodies_in_player_action_radius = []
	bodies_in_player_interaction_radius = []
