class_name Gear
extends StaticBody2D

var grabbing = false
var pinned = false
var grabbed_offset = Vector2()
var prev_pos = Vector2()
var pinned_to: Pin = null
var label = ""

var config: PuzzleConfig.GearConfig
var is_static: bool

func get_sprite_texture(n): return load("res://Assets/Objects/gear-%s.png" % n)

@onready var pin_area = $PinArea
@onready var sprite = $GearSprite

func setup(config: PuzzleConfig.GearConfig, is_static = false):
	self.config = config
	self.is_static = is_static

func _ready():
	position = config.position
	prev_pos = position
	label = config.label
	
	sprite.texture = get_sprite_texture(config.sprite)
	var original_diameter = sprite.texture.get_width()
	
	var scale = (config.radius * 2.0 + 6)/original_diameter
	sprite.scale = Vector2(scale, scale)
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
		pinned_to.gear_type = label
	elif position.x < 230:
		position = prev_pos
		return
	
	prev_pos = position
	get_parent().check_victory()

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and grabbing:
		position = get_global_mouse_position() + grabbed_offset
