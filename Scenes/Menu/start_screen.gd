extends Node2D

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey and event.pressed:
		get_tree().change_scene_to_file("res://Scenes/Menu/rules.tscn")