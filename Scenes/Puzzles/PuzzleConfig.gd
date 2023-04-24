class_name PuzzleConfig
extends Object

class GearConfig:
	var type: String
	var position: Vector2
	
class PinConfig:
	var position: Vector2

var gears: Array[GearConfig]
var pins: Array[PinConfig]

func _init(json_path: String):
	var config = JSON.parse_string(FileAccess.open(json_path, FileAccess.READ).get_as_text())

