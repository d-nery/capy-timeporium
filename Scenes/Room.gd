extends Node2D

var capy_position = 'middle'
var moving = false

func start_puzzle():
	get_tree().change_scene_to_file("res://Scenes/table.tscn")

func _on_table_input_event(viewport, event, shape_idx, new_position):
	if !moving and event is InputEventMouseButton and event.pressed:
		if capy_position == new_position:
			start_puzzle()
			return
			
		moving = true
	
		var animation_name = "%s_to_%s" % [capy_position, new_position]
		capy_position = new_position
		
		$Capy/CapyAnimationPlayer.play(animation_name)

func _on_capy_animation_player_animation_finished(anim_name):
	moving = false
	start_puzzle()

func _on_table_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_table_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
