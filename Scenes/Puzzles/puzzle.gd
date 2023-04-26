class_name Puzzle
extends Node2D

signal puzzle_completed
signal animation_finished

var pin_scene = preload("res://Scenes/Objects/pin.tscn")
var gear_scene = preload("res://Scenes/Objects/gear.tscn")

var pins = []
var gears = []

# Called when the node enters the scene tree for the first time.
func _ready():
	if Config.DEBUG:
		return

	var level = randi_range(1, 4)
	var config = PuzzleConfig.new("res://Scenes/Puzzles/Data/%d.json" % level)
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
		shapes.sort_custom(func (a, b): return b["collider"].get_index() < a["collider"].get_index())

		for shape in shapes:
			if shape["collider"] is Gear:
				grabbing = shape["collider"]
				grabbing.handle_click(true)
				break

	elif event is InputEventMouseButton:
		if grabbing != null:
			grabbing.handle_click(false)
			grabbing = null

	if !Config.DEBUG:
		return

	if event is InputEventKey and event.pressed:
		var g = PuzzleConfig.GearConfig.new({
			"label": "R25",
			"position": [200, 200],
			"radius": 25,
		})

		if event.keycode == KEY_A:
			create_gear(g)

		if event.keycode == KEY_S:
			g.radius = 20
			create_gear(g)

		if event.keycode == KEY_D:
			g.radius = 15
			create_gear(g)

		if event.keycode == KEY_F:
			g.radius = 10
			create_gear(g)

		if event.keycode == KEY_G:
			g.radius = 5
			create_gear(g)

func create_pin(config: PuzzleConfig.PinConfig):
	var pin = pin_scene.instantiate()
	pin.setup(config)
	pins.append(pin)
	add_child(pin)


func create_gear(config: PuzzleConfig.GearConfig, is_static = false, rotating = false):
	var gear = gear_scene.instantiate()
	gear.setup(config, is_static)

	gears.append(gear)
	add_child(gear)

	if rotating:
		gear.start_rotating()


func check_victory():
	if pins.all(func (p: Pin): return p.target_gear == p.gear_type):
		for gear in gears:
			gear.remove_outline()
			gear.start_rotating()

		puzzle_completed.emit()
		print("puzzle completed emitted")

		await get_tree().create_timer(5.0).timeout
		move_child($Clock2, -1)
		$Clock2/AnimatedSprite2D.play("Open-clock")
		await get_tree().create_timer(0.5).timeout
		$Clock2/AnimatedSprite2D.play("Closed")
		await get_tree().create_timer(1.0).timeout
		animation_finished.emit()
		print("animation_finished emitted")

