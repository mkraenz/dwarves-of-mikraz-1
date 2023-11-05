class_name JSONX
extends Node

const STRINGIFIED_INFINITY = "__infinity"


static func stringify_float(x: float):
	if x == INF:
		return STRINGIFIED_INFINITY
	return x


static func try_parse_infinity(x: String):
	if x == STRINGIFIED_INFINITY:
		return INF
	return x
