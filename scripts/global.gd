extends Node

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED or DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

var debug # reference to DebugPanel for property assignment
var current_scene:String

var statue_node: String
var scenes = {
	"DungeonLevelOne": "res://scenes/places/dungeon/dungeon_level_one.tscn",
	"DungeonLevelTwo":  "res://scenes/places/dungeon/dungeon_level_two.tscn",
	"DungeonLevelThree":   "res://scenes/places/dungeon/dungeon_level_three.tscn",
	"FinalLevel": "res://scenes/places/dungeon/FinalLevel.tscn",
	"Tavern":"res://scenes/places/village/tavern.tscn"
}

var player_stats = {
	"max_hp": 50.0,
	"current_hp": 50.0,
	"dmg_bonus": 1.0,
	"money":  50000,
	"level": 1,
	"exp_points": 0.0,
	"speed_bonus":1.0,
	"first_level_finished":false,
	"second_level_finished":false,
	"third_level_finished":false,
	"final_level_finished":false,
	"current_position": Vector3(0,2,0),
	"weapons": ["sword"],
	"current_weapon_index": 0
}


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
	Global.player_stats["current_position"] = Vector3(-4, 2, -4)
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
