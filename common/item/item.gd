extends Node
class_name Item

var id: String

## @type {items.ts#Item}
var base_data: Dictionary
var amount := 0
var seen := false


func init(id_: String, base_data_: Dictionary) -> void:
	id = id_
	base_data = base_data_


func save() -> Dictionary:
	return {
		"id": id,
		"amount": amount,
		"seen": seen,
	}


func load_from(save_dict: Dictionary) -> void:
	amount = save_dict.amount
	seen = save_dict.seen
