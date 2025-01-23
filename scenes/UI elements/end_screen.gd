extends Node2D

@onready var back_to_menu = $Control2/Button

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	back_to_menu.pressed.connect(back)

func back():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
