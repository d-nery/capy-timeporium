class_name PuzzleConfig
extends Object

class GearConfig:
	var type: String
	var label: String
	var position: Vector2
	var radius: int
	
	func _init(data: Dictionary):
		self.type = data["type"]
		self.label = data["label"]
		self.position.x = data["position"][0]
		self.position.y = data["position"][1]
		self.radius = data["radius"]
	
class PinConfig:
	var position: Vector2
	var target_gear: String
	var direction: String
	
	func _init(data: Dictionary):
		self.target_gear = data["target_gear"]
		self.position.x = data["position"][0]
		self.position.y = data["position"][1]
		self.direction = data["direction"]

var start_gear: GearConfig
var target_gears: Array[GearConfig]
var gears: Array[GearConfig]
var pins: Array[PinConfig]

func _init(json_path: String):
	var config = JSON.parse_string(FileAccess.open(json_path, FileAccess.READ).get_as_text())
	start_gear = GearConfig.new(config["start_gear"])
	target_gears.assign(config["target_gears"].map(func (c): return GearConfig.new(c)))
	gears.assign(config["gears"].map(func (c): return GearConfig.new(c)))
	pins.assign(config["pins"].map(func (c): return PinConfig.new(c)))
