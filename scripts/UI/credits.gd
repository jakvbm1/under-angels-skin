extends Node2D

@onready var prev_button = $Button
@onready var next_button = $Button2
@onready var back_button = $Button3
@onready var text_credits = $Label2

var text_1 = "Game developed by \n Tymoteusz Dybał \n Damian Knopek \n Jakub Miarka"
var text_2 = "Following assets were used during game production: \n
 Crowbar (https://skfb.ly/onBGQ) by Superior is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/). \n
Skeleton by Alexander Brodin [CC-BY] via Poly Pizza \n
Power Gun by Dheeraj Dolce [CC-BY] via Poly Pizza \n
Chest by Quaternius (https://poly.pizza/m/O72u4Drp8k) \n"
var text_3 ="Low Poly Torch pair with… extra-sharp flames 🔥 (https://skfb.ly/oRsq9) by CypherPoet is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).\n
PT Medieval Peasant 01 A (https://skfb.ly/6CrqC) by Polytope is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).\n
Low Poly PSX Angel (https://skfb.ly/oWCAz) by Thomas_Alonso is licensed under Creative Commons Attribution-NonCommercial (http://creativecommons.org/licenses/by-nc/4.0/).\n
AngelStatue by Zsky [CC-BY] via Poly Pizza \n
Sword (https://skfb.ly/oynVy) by lkzero_ is licensed under Creative Commons Attribution (http://creativecommons.org/licenses/by/4.0/).
"

var texts = [text_1, text_2, text_3]
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
