extends Node3D
@onready var player: Player = null
@onready var label = $Label
@export var interaction_distance: float = 2.0
func _ready():
	player = get_tree().get_first_node_in_group("player")
	label.visible = false
	
func _process(delta: float):
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance_to_player < interaction_distance:
		label.visible = true
		if Input.is_action_just_pressed("interact"):
			
			Global.player_stats["max_hp"] = player.max_hp
			Global.player_stats["current_hp"] = player.current_hp 
			Global.player_stats["dmg_bonus"] = player.dmg_bonus  
			Global.player_stats["money"] = player.money 
			Global.player_stats["level"] = player.level  
			Global.player_stats["exp_points"] = player.exp_points 
			
			if get_node("..").name == "DungeonLevelOne":
				
				Global.player_stats["current_position"] = Vector3(-1, 2, 1)		
			else:
				Global.player_stats["current_position"] = Vector3(1,2, -214)
			get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_two.tscn")
		
	else:
		label.visible = false
	
