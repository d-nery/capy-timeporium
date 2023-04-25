class_name Puzzle
extends Node2D

signal puzzle_completed

var pin_scene = preload("res://Scenes/Objects/pin.tscn")
var gear_scene = preload("res://Scenes/Objects/gear.tscn")

var pins = []
var gears = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = PuzzleConfig.new("res://Scenes/Puzzles/Data/2.json")
	for gear in config.gears:
		create_gear(gear)
		
	for pin in config.pins:
		create_pin(pin)
		
	for gear in config.target_gears:
		create_gear(gear, true)
		
	create_gear(config.start_gear, true, true)

# Guarantees only one gear is clicked at a time
var grabbing: Gear = null
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var params = PhysicsPointQueryParameters2D.new()
		params.position = get_global_mouse_position()
		var shapes = get_world_2d().direct_space_state.intersect_point(params)
		shapes.sort_custom(func (a, b): b["collider"].get_index() < a["collider"].get_index())
		
		for shape in shapes:
			if shape["collider"] is Gear:
				grabbing = shape["collider"]
				grabbing.handle_click(true)
				break

	elif event is InputEventMouseButton:
		if grabbing != null:
			grabbing.handle_click(false)
			grabbing = null

func create_pin(config: PuzzleConfig.PinConfig):
	var pin = pin_scene.instantiate()
	pin.setup(config)
	pins.append(pin)
	add_child(pin)

func create_gear(config: PuzzleConfig.GearConfig, is_static = false, rotating = false):
	var gear = gear_scene.instantiate()
	gear.setup(config, is_static)

	if rotating:
		gear.start_rotating()

	gears.append(gear)
	add_child(gear)
	
func check_victory():
	if pins.all(func (p: Pin): return p.target_gear == p.gear_type):
		move_child($Clock2, -1)
		$Clock2/AnimatedSprite2D.play("Open-clock")
		await get_tree().create_timer(0.5).timeout
		$Clock2/AnimatedSprite2D.play("Closed")
		await get_tree().create_timer(1.0).timeout
		puzzle_completed.emit()

