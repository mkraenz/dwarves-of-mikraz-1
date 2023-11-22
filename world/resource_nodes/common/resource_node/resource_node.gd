extends Node2D

@export var mining: Mining
@export var stats: Stats

var gdata := GData


func _ready():
	if not stats.initialized_on_load:
		var resource_node := gdata.get_resource_node(mining.resource_node_type)
		stats.max_hp = resource_node.hp
		stats.hp = resource_node.hp
