class_name Gear
extends StaticBody2D

var grabbing = false
var pinned = false
var grabbed_offset = Vector2()
var prev_pos = Vector2()
var pinned_to: Pin = null
var parent: Puzzle = null

@onready var pin_area = $PinArea

func _ready():
	prev_pos = position

func handle_click(is_pressed):
	grabbing = is_pressed
	if grabbing:
		get_parent().move_child(self, -1)
		pinned = false
		if pinned_to:
			pinned_to.has_gear = false
		pinned_to = null
	else:
		if pin_area.has_overlapping_bodies():
			var pin = pin_area.get_overlapping_bodies()[0]
			if pin == pinned_to:
				return
			if pin.has_gear:
				position = prev_pos
				return
			position = pin.position
			pinned = true
			pinned_to = pin
			pinned_to.has_gear = true
		elif position.x < 230:
			position = prev_pos
		prev_pos = position
		return
	grabbed_offset = position - get_global_mouse_position()

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and grabbing:
		position = get_global_mouse_position() + grabbed_offset
