extends Node

class PuzzleState:
	var active: bool = false
	var complete: bool = false
	var position: String
	
	func _init(position: String):
		self.position = position

@export var puzzles = {
	'left': PuzzleState.new('left'),
	'middle': PuzzleState.new('middle'),
	'right': PuzzleState.new('right')
}

@export var capy_position = 'middle'

func start_puzzle():
	var state = get_puzzle(capy_position)
	if state.complete:
		return
	
	for puzzle in puzzles.values():
		puzzle.active = false

	state.active = true
	get_tree().change_scene_to_file("res://Scenes/table.tscn")

func complete_puzzle():
	get_puzzle(capy_position).complete = true

func get_puzzle(position: String):
	for p in puzzles.values():
		if p.position == position:
			return p

