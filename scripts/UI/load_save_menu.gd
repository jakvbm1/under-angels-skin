extends Node2D

@onready var slot_1 = $Button
@onready var slot_2 = $Button2
@onready var slot_3 = $Button3
@onready var back_menu = $Button4

func _ready():
	slot_1.pressed.connect(load_slot_1)
	slot_2.pressed.connect(load_slot_2)
	slot_3.pressed.connect(load_slot_3)
	back_menu.pressed.connect(back_to_menu)
	

func back_to_menu():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
	
func load_from_slot(slot: int):
	print('not implemented yet ;p')
	
func load_slot_1():
	load_from_slot(1)

func load_slot_2():
	load_from_slot(2)

func load_slot_3():
	load_from_slot(3)
