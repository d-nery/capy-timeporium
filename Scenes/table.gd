extends Node2D

@onready var bottom_bar = $BottomBar

func _ready():
    bottom_bar.start_timer()


func _on_game_finished():
    if (bottom_bar.timer.time_left >= 20):
        RoomState.coins = 15
    elif(bottom_bar.timer.time_left >= 10):
        RoomState.coins = 10
    else:
        RoomState.coins = 5

    RoomState.complete_puzzle()
    get_tree().change_scene_to_file("res://Scenes/Room.tscn")


func _on_button_2_pressed():
    get_tree().change_scene_to_file("res://Scenes/Room.tscn")
