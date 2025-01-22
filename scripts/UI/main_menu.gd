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
	get_tree().change_scene_to_file("res://scenes/UI elements/intro.tscn")
	Global.player_stats["max_hp"] = 100.0
	Global.player_stats["current_hp"] = 50.0
	Global.player_stats["dmg_bonus"] = 1.0
	Global.player_stats["money"] = 5000
	Global.player_stats["level"] = 1
	Global.player_stats["exp_points"] = 0.0
	Global.player_stats["speed_bonus"] = 0.0
	Global.player_stats["first_level_finished"] = false
	Global.player_stats["second_level_finished"] = false
	Global.player_stats["third_level_finished"] = false
	Global.player_stats["final_level_finished"] = false
	Global.player_stats["current_position"] =  Vector3(0,2,0)



func load_game_from_file():
	get_tree().change_scene_to_file("res://scenes/UI elements/load_save menu.tscn")
	
func show_credits():
	get_tree().change_scene_to_file("res://scenes/UI elements/credits.tscn")
