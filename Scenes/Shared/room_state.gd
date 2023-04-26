extends Node


class ClientState:
	var active: bool = false
	var complete: bool = false
	var position: String

	func _init(pos: String):
		self.position = pos


var clients = {
	"left": ClientState.new("left"),
	"middle": ClientState.new("middle"),
	"right": ClientState.new("right")
}

var capy_position = "middle"


func start_puzzle():
	var state = get_client(capy_position)
	if state.complete:
		return

	for client in clients.values():
		client.active = false

	state.active = true
	get_tree().change_scene_to_file("res://Scenes/table.tscn")


func complete_puzzle():
	get_client(capy_position).complete = true


func get_client(position: String):
	for client in clients.values():
		if client.position == position:
			return client


func restart():
	clients = {
		"left": ClientState.new("left"),
		"middle": ClientState.new("middle"),
		"right": ClientState.new("right")
	}
	capy_position = "middle"


var coins: int = 0:
	get:
		return coins
	set(value):
		coins += value

var day: int = 1:
	get:
		return day
	set(value):
		day += value


var debt: int = 150:
	get: 
		return debt
	set(value):
		debt -= value
		if debt <= 0:
			debt = 0
