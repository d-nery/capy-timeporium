extends CanvasLayer

@onready var timer_text = $Control/HBoxContainer/HBoxContainer2/Label
@onready var timer = $Control/HBoxContainer/HBoxContainer2/Timer
@onready var coins = $Control/HBoxContainer/HBoxContainer/Value

func _process(delta):
	timer_text.text = "%d:%02d" % [floor(timer.time_left / 60), int(timer.time_left) % 60]
	coins.text = str(CoinCounter.coins)
	

func start_timer():
	$Control/HBoxContainer/HBoxContainer2/Timer.start(30)
