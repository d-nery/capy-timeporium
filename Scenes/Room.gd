extends Node2D

var capy_position = 'middle'
var moving = false

func move(new_position):
	if moving or new_position == capy_position:
		return
	
	moving = true
	
	var animation_name = "%s_to_%s" % [capy_position, new_position]
	capy_position = new_position
	
	$Capy/CapyAnimationPlayer.play(animation_name)

func _on_left_table_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		move("left")

func _on_middle_table_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		move("middle")

func _on_right_table_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		move("right")

func _on_capy_animation_player_animation_finished(anim_name):
	moving = false
