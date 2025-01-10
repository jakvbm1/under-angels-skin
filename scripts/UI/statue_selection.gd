extends Control



@onready var save_game = $Button2
@onready var teleport = $Button
@onready var exit = $Button3

@onready var save_menu = $SaveGameMenu
@onready var save_slot_1 = $SaveGameMenu/Button
@onready var save_slot_2 = $SaveGameMenu/Button2
@onready var save_slot_3 = $SaveGameMenu/Button3
@onready var save_go_back = $SaveGameMenu/Button4

func _ready():
	exit.pressed.connect(self.exit_menu)
	teleport.pressed.connect(self.open_save_slots)
	save_go_back.pressed.connect(self.close_save_slots)
	save_slot_1.pressed.connect(self.slot_1)
	save_slot_2.pressed.connect(self.slot_2)
	save_slot_3.pressed.connect(self.slot_3)
	save_menu.visible = false

func exit_menu():
	self.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func open_save_slots():
	save_game.visible = false
	teleport.visible = false
	exit.visible = false
		
	save_game.disabled = true
	teleport.disabled = true
	exit.disabled = true
		
	save_menu.visible = true
	
func close_save_slots():
	save_game.visible = true
	teleport.visible = true
	exit.visible = true	
	save_game.disabled = false
	teleport.disabled = false
	exit.disabled = false
	save_menu.visible = false
	
	
func slot_1():
	save_state(1)

func slot_2():
	save_state(2)
	
func slot_3():
	save_state(3)

func save_state(slot:int):
	print('to zostawiam tobie do implementacji tymku')
	print(slot)
		
		
