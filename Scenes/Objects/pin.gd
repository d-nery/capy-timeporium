class_name Pin
extends StaticBody2D

var gear_type = null
var target_gear: String
var direction: String

func setup(config: PuzzleConfig.PinConfig):
	position = config.position
	target_gear = config.target_gear
	direction = config.direction
	$Label.text = target_gear
