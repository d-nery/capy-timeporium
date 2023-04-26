extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	RoomState.debt = RoomState.coins
	
	$Panel/DayValue.text = str(RoomState.day)
	$Panel/MoneyValue.text = str(RoomState.coins)
	$Panel/DebtValue.text = str(RoomState.debt)



func _on_button_pressed():
	RoomState.restart()
	if RoomState.debt <= 0:
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	else: 
		RoomState.coins = -RoomState.coins
		RoomState.day = 1
		get_tree().change_scene_to_file("res://Scenes/Menu/story.tscn")
