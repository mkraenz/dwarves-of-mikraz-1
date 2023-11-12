extends Label

var gdata := GData


func _ready():
	text = "v%s" % gdata.version
