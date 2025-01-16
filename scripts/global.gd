extends Node

var debug # reference to DebugPanel for property assignment
var current_scene:String
var scenes = {
	"DungeonLevelOne": "res://scenes/places/dungeon/dungeon_level_one.tscn",
	"DungeonLevelTwo":  "res://scenes/places/dungeon/dungeon_level_two.tscn",
	"DungeonLevelThree":   "res://scenes/places/dungeon/dungeon_level_three.tscn",
	"FinalLevel": "res://scenes/places/dungeon/FinalLevel.tscn",
	"Tavern":"res://scenes/places/village/tavern.tscn"
}

var player_stats = {
	"max_hp": 100.0,
	"current_hp": 50.0,
	"dmg_bonus": 1,
	"money":  0,
	"level": 1,
	"exp_points": 0.0,
	"current_scene": "",
	"first_level_finished":false,
	"second_level_finished":false,
	"third_level_finished":false,
	"final_level_finished":false,
	"current_position": Vector3(0,1,0)
}
