extends Node2D
@onready var button = $Button

func _ready():
	button.pressed.connect(back_to_menu)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	

func back_to_menu():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
