extends Node2D

var moving = false

var capyOffsets = {
	'left': Vector2(-75, 0),
	'middle': Vector2(0, 0),
	'right': Vector2(100, 0)
}

func _ready():
	$Capy.offset = capyOffsets[GameState.capy_position]
	for puzzle in GameState.puzzles.values():
		if puzzle.complete:
			var node = get_node("Clients/%sClient" % puzzle.position.capitalize())
			if puzzle.active:
				moving = true
				node.get_node("AnimationPlayer").play("leave")
			else:
				node.queue_free()

func _on_table_input_event(viewport, event, shape_idx, new_position):
	if !moving and event is InputEventMouseButton and event.pressed:
		print(GameState.capy_position, new_position)
		if GameState.capy_position == new_position:
			GameState.start_puzzle()
			return
			
		moving = true
	
		var animation_name = "%s_to_%s" % [GameState.capy_position, new_position]
		GameState.capy_position = new_position
		
		$Capy/CapyAnimationPlayer.play(animation_name)

func _on_capy_animation_player_animation_finished(anim_name):
	moving = false
	GameState.start_puzzle()

func _on_table_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_table_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

 
func is_puzzle_incomplete(puzzle):
	return !puzzle.complete

func _on_animation_player_animation_finished(anim_name):
	moving = false

	var any_incomplete = false
	for p in GameState.puzzles.values():
		if !p.complete:
			any_incomplete = true
			break
			
	if !any_incomplete:
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
