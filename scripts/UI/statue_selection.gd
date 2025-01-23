extends Control

var save_path = "res://scripts/saves/save"

@onready var save_game = $Button
@onready var teleport = $Button2
@onready var exit = $Button3
@onready var player:Player
@onready var save_menu = $SaveGameMenu
@onready var save_slot_1 = $SaveGameMenu/Button
@onready var save_slot_2 = $SaveGameMenu/Button2
@onready var save_slot_3 = $SaveGameMenu/Button3
@onready var save_go_back = $SaveGameMenu/Button4
@onready var teleport_go_back = $LocationSelect/Button
@onready var teleport_menu = $LocationSelect

func _ready():
	
	player = get_tree().get_first_node_in_group("player")
	exit.pressed.connect(self.exit_menu)
	save_game.pressed.connect(self.open_save_slots)
	save_go_back.pressed.connect(self.close_save_slots)
	save_slot_1.pressed.connect(self.slot_1)
	save_slot_2.pressed.connect(self.slot_2)
	save_slot_3.pressed.connect(self.slot_3)
	
	teleport_go_back.pressed.connect(self.close_teleport)
	teleport.pressed.connect(self.open_teleport)
	save_menu.visible = false
	teleport_menu.visible = false

	

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
	Global.player_stats["max_hp"] = player.max_hp
	Global.player_stats["current_hp"] = player.current_hp 
	Global.player_stats["dmg_bonus"] = player.dmg_bonus  
	Global.player_stats["money"] = player.money 
	Global.player_stats["level"] = player.level  
	Global.player_stats["exp_points"] = player.exp_points 
	Global.current_scene = get_node("../..").name
	Global.statue_node = get_node("..").name
	
	print(Global.current_scene)
	print(Global.statue_node)
	
	
	var file = FileAccess.open(save_path + str(slot) +".save", FileAccess.WRITE)
	file.store_var(Global.player_stats)
	file.store_var(Global.current_scene)
	file.store_var(Global.statue_node)
	
	file.close()
	
		
func open_teleport():
	save_game.visible = false
	teleport.visible = false
	exit.visible = false
		
	save_game.disabled = true
	teleport.disabled = true
	exit.disabled = true
		
	teleport_menu.visible = true
	
func close_teleport():
	save_game.visible = true
	teleport.visible = true
	exit.visible = true
		
	save_game.disabled = false
	teleport.disabled = false
	exit.disabled = false
		
	teleport_menu.visible = false
		
