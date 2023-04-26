extends Node2D


func _ready():
	$Clients/AnimationPlayer.play("clients_entering")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "clients_entering":
		$Clocks/AnimationPlayer.play("clocks_to_table")
	elif anim_name == "clocks_to_table":
		get_tree().change_scene_to_file("res://Scenes/Room.tscn")
