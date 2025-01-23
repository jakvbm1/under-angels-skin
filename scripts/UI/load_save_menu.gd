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
			Global.current_scene = file.get_var()
			Global.statue_node = file.get_var()
			print("im here")
			file.close()
		else:
			print("Failed to open file for loading:", file_path)
	else:
		print("Save file does not exist:", file_path)
		
	
	if Global.current_scene == "DungeonLevelOne" and Global.statue_node == "AngelStatue2":
		Global.tel_lv1_end()
	if Global.current_scene == "DungeonLevelOne" and Global.statue_node == "AngelStatue":
		Global.tel_lv1_beg()
	if Global.current_scene == "DungeonLevelTwo" and Global.statue_node == "AngelStatue2":
		Global.tel_lv2_end()
	if Global.current_scene == "DungeonLevelTwo" and Global.statue_node == "AngelStatue":
		Global.tel_lv2_beg()
	if Global.current_scene == "DungeonLevelThree" and Global.statue_node == "AngelStatue2":
		Global.tel_lv3_beg()
	if Global.current_scene == "FinalLevel" and Global.statue_node == "AngelStatue2":
		Global.tel_lv4_end()
	if Global.current_scene == "FinalLevel" and Global.statue_node == "AngelStatue":
		Global.tel_lv4_beg()
	if Global.current_scene == "Tavern":
		Global.tel_tav()
	
	
func load_slot_1():
	load_from_slot(1)

func load_slot_2():
	load_from_slot(2)

func load_slot_3():
	load_from_slot(3)
