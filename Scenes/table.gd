extends Node2D

@onready var bottom_bar = $BottomBar

# Called when the node enters the scene tree for the first time.
func _ready():
	bottom_bar.start_timer()


func _on_button_pressed():
	if (bottom_bar.timer.time_left >= 20):
		CoinCounter.coins = 15
	elif(bottom_bar.timer.time_left >= 10):
		CoinCounter.coins = 10
	else:
		CoinCounter.coins = 5
	get_tree().change_scene_to_file("res://Scenes/Room.tscn")	


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://Scenes/Room.tscn")
