extends Object

class_name InputUtils

static func is_click(node: Node, event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return true
			
	return false
	
