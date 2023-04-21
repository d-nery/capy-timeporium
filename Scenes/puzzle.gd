class_name Puzzle
extends Node2D

var pin_scene = preload("res://Scenes/Objects/pin.tscn")
var gear_scene = preload("res://Scenes/Objects/gear.tscn")

var pins = []
var gears = []

# Called when the node enters the scene tree for the first time.
func _ready():
	create_pin(Vector2(150, 150))
	create_pin(Vector2(100, 100))
	create_pin(Vector2(150, 100))
	create_pin(Vector2(100, 150))
	create_gear(Vector2(260, 50))
	create_gear(Vector2(260, 100))
	create_gear(Vector2(279, 200))

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

func create_pin(pos: Vector2):
	var pin = pin_scene.instantiate()
	pin.position = pos
	pins.append(pin)
	add_child(pin)

func create_gear(pos: Vector2):
	var gear = gear_scene.instantiate()
	gear.position = pos
	gear.parent = self
	gears.append(gear)
	add_child(gear)
