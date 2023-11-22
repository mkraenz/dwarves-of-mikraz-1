extends Node2D

@export var mining: Mining
@export var stats: Stats

var gdata := GData


func _ready():
	var resource_node := gdata.get_resource_node(mining.resource_node_type)
	stats.max_hp = resource_node.hp
