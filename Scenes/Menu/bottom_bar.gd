extends CanvasLayer

@onready var timer_text = $Control/HBoxContainer/HBoxContainer2/Label
@onready var timer = $Control/HBoxContainer/HBoxContainer2/Timer
@onready var coins = $Control/HBoxContainer/HBoxContainer/Value

func _process(_delta):
	timer_text.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]
	coins.text = str(RoomState.coins)

	if (RoomState.coins >= 100):
		get_tree().change_scene_to_file("res://Scenes/credits.tscn")

func hide_timer():
	$Control/HBoxContainer/HBoxContainer2.visible = false
	
func show_timer():
	$Control/HBoxContainer/HBoxContainer2.visible = true

func start_timer():
	show_timer()
	$Control/HBoxContainer/HBoxContainer2/Timer.start(30)

func stop_timer():
	$Control/HBoxContainer/HBoxContainer2/Timer.set_paused(true)
