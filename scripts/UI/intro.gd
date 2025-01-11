extends Node2D

var displayed: int = 0

@onready var next = $Button
@onready var image_holder = $Control/TextureRect
@onready var text_display = $Label

func _ready():
	text_display.text = 'On the remote island of Dohrnii...'
	image_holder.texture = load("res://assets/sprites/island_1.png") as Texture2D
	next.pressed.connect(advance_scene)

func advance_scene():
	displayed = displayed + 1
	
	if displayed == 1:
		text_display.text = "a giant hole has appeared."
		image_holder.texture = load("res://assets/sprites/island_2.png") as Texture2D
		
	if displayed == 2:
		text_display.text = "All sorts of monstrocities came out of it to harass the locals. \n
		Will you free them out of their predicament?"
		
	if displayed == 3:
		get_tree().change_scene_to_file("res://scenes/places/village/tavern.tscn")
	
