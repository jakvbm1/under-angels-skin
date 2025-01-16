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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	Global.player_stats["max_hp"] = player.max_hp
	Global.player_stats["current_hp"] = player.current_hp 
	Global.player_stats["dmg_bonus"] = player.dmg_bonus  
	Global.player_stats["money"] = player.money 
	Global.player_stats["level"] = player.level  
	Global.player_stats["exp_points"] = player.exp_points 
	
	if Global.player_stats["first_level_finished"]==false:
		but_lv2_s.disabled = true
		but_lv1_e.disabled = true
	if Global.player_stats["second_level_finished"]==false:
		but_lv3_s.disabled = true
		but_lv2_e.disabled = true
	if Global.player_stats["third_level_finished"]==false:
		but_lvf_s.disabled = true
		but_lv3_e.disabled = true	
	if Global.player_stats["final_level_finished"]==false:
		but_lvf_e.disabled = true
		
	but_lv1_s.pressed.connect(tel_lv1_beg)
	but_lv1_e.pressed.connect(tel_lv1_end)
	but_lv2_s.pressed.connect(tel_lv2_beg)
	but_lv2_e.pressed.connect(tel_lv2_end)
	but_lv3_s.pressed.connect(tel_lv3_beg)
	but_lv3_e.pressed.connect(tel_lv3_end)
	but_lvf_s.pressed.connect(tel_lv4_beg)
	but_lvf_e.pressed.connect(tel_lv4_end)
	but_tav.pressed.connect(tel_tav)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func tel_lv1_beg():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_one.tscn")
	Global.player_stats["current_position"] = Vector3(3, 1, 1)
func tel_lv1_end():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_one.tscn")
	Global.player_stats["current_position"] = Vector3(11, 1, 87)
func tel_lv2_beg():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_two.tscn")
	Global.player_stats["current_position"] = Vector3(-4, 1, 0)
func tel_lv2_end():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_two.tscn")
	Global.player_stats["current_position"] = Vector3(4, 1, -223)
func tel_lv3_beg():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_three.tscn")
	Global.player_stats["current_position"] = Vector3(-4, 1.5, -4)
func tel_lv3_end():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_three.tscn")
	Global.player_stats["current_position"] = Vector3(0, 3.5, -103)
func tel_lv4_beg():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/FinalLevel.tscn")
	Global.player_stats["current_position"] = Vector3(-1, 1, 3)
func tel_lv4_end():
	get_tree().change_scene_to_file("res://scenes/places/dungeon/FinalLevel.tscn")
	Global.player_stats["current_position"] = Vector3(15, 1, -156)
func tel_tav():
	get_tree().change_scene_to_file("res://scenes/places/village/tavern.tscn")
	Global.player_stats["current_position"] = Vector3(3, 2, 0)
