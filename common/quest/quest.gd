extends Node
class_name Quest

signal progress_updated
signal quest_completed

var id: String
## @type {{ current_amount: int; id: ItemId; required_amount: int}[]}
var progress: Array = []:
	set = set_progress
var started := false
var completed := false
var base_data: Dictionary = {}


func set_progress(val: Array) -> void:
	progress = val
	progress_updated.emit()


## idea: Basically mimicing a constructor.
## This is to force compiler errors when we change quest's 'constructor' aka init method without adjusting it's clients.
func init(id_: String, base_data_: Dictionary):
	id = id_
	base_data = base_data_


func save() -> Dictionary:
	var save_dict = {
		"id": id,
		# "progress": progress, # probably should be calculated again on load
		"started": started,
		"completed": completed,
	}
	return save_dict


func load_from(save_data: Dictionary) -> void:
	started = save_data.started
	completed = save_data.completed


static func from_save_data(save_data: Dictionary, base_data_) -> Quest:
	var quest = Quest.new()
	quest.init(save_data.id, base_data_)
	quest.load_from(save_data)
	return quest
