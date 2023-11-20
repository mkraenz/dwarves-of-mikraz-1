class_name FeatureFlags
extends Node

static var debug = false:
	get:
		return OS.has_feature("debug")

static var no_building_costs = false:
	get:
		return OS.has_feature("debug") and true

static var filled_inventory = false:
	get:
		return OS.has_feature("debug") and true

static var over_nine_thousand = false:
	get:
		return OS.has_feature("debug") and true
