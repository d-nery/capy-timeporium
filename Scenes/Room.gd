extends Node2D

var clientScene = preload("res://Scenes/Actors/client.tscn")

var moving = false

var capyOffsets = {
	'left': Vector2(-75, 0),
	'middle': Vector2(0, 0),
	'right': Vector2(100, 0)
}

func _ready():
	$Capy.offset = capyOffsets[RoomState.capy_position]

	for client in RoomState.clients.values():
		if client.complete:
			var node = get_node("Clients/%sClient" % client.position.capitalize())
			if client.active:
				moving = true
				var sprite = node.get_node("Sprite2D")
				sprite.frame = sprite.frame + 4
				node.get_node("AnimationPlayer").play("leave")
			else:
				node.queue_free()


func _on_table_input_event(_viewport, event, _shape_idx, new_position):
	if !moving and event is InputEventMouseButton and event.pressed:
		print(RoomState.capy_position, new_position)
		if RoomState.capy_position == new_position:
			RoomState.start_puzzle()
			return

		moving = true

		var animation_name = "%s_to_%s" % [RoomState.capy_position, new_position]
		RoomState.capy_position = new_position

		$Capy/CapyAnimationPlayer.play(animation_name)

func _on_capy_animation_player_animation_finished(_anim_name):
	moving = false
	RoomState.start_puzzle()

func _on_table_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_table_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_animation_player_animation_finished(_anim_name):
	moving = false

	var any_incomplete = RoomState.clients.values().any(func(p): return !p.complete)

	if !any_incomplete:
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
