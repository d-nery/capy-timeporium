extends Object

class_name InputUtils

static func is_click(event: InputEvent):
	return event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
