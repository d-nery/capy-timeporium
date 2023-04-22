extends Resource

class GearConfig:
	extends Node
	var type: String
	var position: Vector2
	
class PinConfig:
	extends Node
	var position: Vector2

@export var gears: Array[GearConfig]
@export var pins: Array[PinConfig]
