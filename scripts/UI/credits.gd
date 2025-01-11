extends Node2D

@onready var prev_button = $Button
@onready var next_button = $Button2
@onready var back_button = $Button3
@onready var text_credits = $Label2

var texts = ['text 1', 'text 2', 'text 3']
var displayed: int = 0

func _ready():
	text_credits.text = texts[displayed]
	prev_button.pressed.connect(previous_text)
	next_button.pressed.connect(next_text)
	back_button.pressed.connect(back_to_menu)

func next_text():
	displayed = (displayed + 1) % 3
	text_credits.text = texts[displayed]
	
func previous_text():
	if displayed == 0:
		displayed = 2
	else:
		displayed = displayed-1
		
	text_credits.text = texts[displayed]
	
func back_to_menu():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
