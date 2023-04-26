extends Node2D

func _ready():
    $AnimationPlayer.play("credits")

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        RoomState.restart()
        get_tree().change_scene_to_file("res://Scenes/Menu/start_screen.tscn")



func _on_animation_player_animation_finished(anim_name):
    if anim_name == "credits":
        get_tree().change_scene_to_file("res://Scenes/Menu/start_screen.tscn")
