class_name Gear
extends StaticBody2D

var grabbing = false
var pinned = false
var grabbed_offset = Vector2()
var prev_pos = Vector2()
var pinned_to: Pin = null
var type = ""
var label = ""

var config: PuzzleConfig.GearConfig
var is_static: bool

@onready var pin_area = $PinArea
@onready var sprite = $GearSprite

func setup(config: PuzzleConfig.GearConfig, is_static = false):
	self.config = config
	self.is_static = is_static

func _ready():
	position = config.position
	prev_pos = position
	type = config.type
	label = config.label
	
	var d = config.radius * 2.0 + 6
	sprite.scale = Vector2(d/90.0, d/90.0)
	$Label.text = label
	if is_static:
		$GrabArea.shape.radius = 0
	else:
		$GrabArea.shape.radius = config.radius

func handle_click(is_pressed):
	grabbing = is_pressed
	grabbed_offset = position - get_global_mouse_position()

	if grabbing:
		get_parent().move_child(self, -1)
		pinned = false
		if pinned_to:
			pinned_to.gear_type = null
		pinned_to = null
		return

	if pin_area.has_overlapping_bodies():
		var pin = pin_area.get_overlapping_bodies()[0]
		if pin == pinned_to:
			return

		if pin.gear_type != null:
			position = prev_pos
			return

		position = pin.position
		pinned = true
		pinned_to = pin
		pinned_to.gear_type = type
	elif position.x < 230:
		position = prev_pos
		return
	
	prev_pos = position
	get_parent().check_victory()

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and grabbing:
		position = get_global_mouse_position() + grabbed_offset
