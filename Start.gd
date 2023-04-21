extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if InputUtils.is_click(event):
		start_game()

func start_game():
	get_tree().change_scene_to_file("res://some_other_screen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
