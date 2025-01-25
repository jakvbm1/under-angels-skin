extends Control

@onready var but_lv1_s = $Control/Button
@onready var but_lv1_e = $Control/Button2
@onready var but_lv2_s = $Control/Button3
@onready var but_lv2_e = $Control2/Button
@onready var but_lv3_s = $Control2/Button2
@onready var but_lv3_e = $Control2/Button3
@onready var but_lvf_s = $Control3/Button
@onready var but_lvf_e = $Control3/Button2
@onready var but_tav = $Control3/Button3
@onready var player:Player = null


func refresh() ->void:
	Global.player_stats["max_hp"] = player.max_hp
	Global.player_stats["current_hp"] = player.current_hp 
	Global.player_stats["dmg_bonus"] = player.dmg_bonus  
	Global.player_stats["money"] = player.money 
	Global.player_stats["level"] = player.level  
	Global.player_stats["exp_points"] = player.exp_points 
	Global.player_stats["weapons"] = player.weapons
	Global.player_stats["current_weapon_index"] = player.current_weapon_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	player = get_tree().get_first_node_in_group("player")
	
	
	
	
	
		
	but_lv1_s.pressed.connect(Global.tel_lv1_beg)
	but_lv1_e.pressed.connect(Global.tel_lv1_end)
	but_lv2_s.pressed.connect(Global.tel_lv2_beg)
	but_lv2_e.pressed.connect(Global.tel_lv2_end)
	but_lv3_s.pressed.connect(Global.tel_lv3_beg)
	but_lv3_e.pressed.connect(Global.tel_lv3_end)
	but_lvf_s.pressed.connect(Global.tel_lv4_beg)
	but_lvf_e.pressed.connect(Global.tel_lv4_end)
	but_tav.pressed.connect(Global.tel_tav)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	refresh()
	if Global.player_stats["first_level_finished"]==false:
		but_lv2_s.disabled = true
		but_lv1_e.disabled = true
	if Global.player_stats["second_level_finished"]==false:
		but_lv3_s.disabled = true
		but_lv2_e.disabled = true
	else:
		but_lv3_s.disabled = false
		but_lv2_e.disabled = false
	if Global.player_stats["third_level_finished"]==false:
		but_lvf_s.disabled = true
		but_lv3_e.disabled = true	
	if Global.player_stats["final_level_finished"]==false:
		but_lvf_e.disabled = true
