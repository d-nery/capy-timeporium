extends Object

class_name InputUtils

static func is_click(node: Node2D, event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		return node.get_rect().has_point(node.to_local(event.position))
			
	return false
	
