extends Node2D

@onready var new_game = $Button
@onready var load_game = $Button2
@onready var credits = $Button3

#ta taverna bedzie zmieniona na krotka scenke ktora zrobie przez weekend
#var credit - jak zrobimy scenke z creditami to tam bedzie

func _ready():
	load_game.pressed.connect(load_game_from_file)
	new_game.pressed.connect(load_new_game)
	credits.pressed.connect(show_credits)
	
func load_new_game():
	get_tree().change_scene_to_file("res://scenes/places/village/tavern.tscn")
	
func load_game_from_file():
	get_tree().change_scene_to_file("res://scenes/UI elements/load_save menu.tscn")
	
func show_credits():
	get_tree().change_scene_to_file("res://scenes/UI elements/credits.tscn")
