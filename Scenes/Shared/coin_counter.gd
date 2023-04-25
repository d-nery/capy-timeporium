extends Node

@export var coins: int = 0:
	get:
		return coins
	set(value):
		coins += value
