extends Node2D

var save_path = "res://scripts/saves/save"

@onready var slot_1 = $Button
@onready var slot_2 = $Button2
@onready var slot_3 = $Button3
@onready var back_menu = $Button4
@onready var player

var PlayerScene = preload("res://scenes/entities/players/player.tscn")

func _ready():
	
	slot_1.pressed.connect(load_slot_1)
	slot_2.pressed.connect(load_slot_2)
	slot_3.pressed.connect(load_slot_3)
	back_menu.pressed.connect(back_to_menu)
	

func back_to_menu():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
	
func load_from_slot(slot: int):
	var file_path = save_path + str(slot) + ".save"
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		if file:
			Global.player_stats = file.get_var()
			print(Global.player_stats["money"])
			file.close()
		else:
			print("Failed to open file for loading:", file_path)
	else:
		print("Save file does not exist:", file_path)
	get_tree().change_scene_to_file(Global.scenes[Global.player_stats.current_scene])
func load_slot_1():
	load_from_slot(1)

func load_slot_2():
	load_from_slot(2)

func load_slot_3():
	load_from_slot(3)
