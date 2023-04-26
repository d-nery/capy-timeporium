class_name Pin
extends StaticBody2D

var gear_type = null
var target_gear = null
var direction: String

func setup(config: PuzzleConfig.PinConfig):
    position = config.position
    target_gear = config.target_gear
    direction = config.direction
    $Label.text = target_gear if target_gear else ""
    $Label.visible = Config.DEBUG
