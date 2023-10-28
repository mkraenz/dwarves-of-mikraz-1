extends Node

var eventbus := Eventbus
var bodies_in_player_action_radius: Array = []


func reset() -> void:
	bodies_in_player_action_radius = []
