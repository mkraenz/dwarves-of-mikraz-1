class_name FeatureFlags
extends Node

static var debug = false:
	get:
		return OS.has_feature("debug")
