extends Camera2D

var gstate := GState


func _ready():
	gstate.cam = self
