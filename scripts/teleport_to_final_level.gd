extends Area3D
@onready var player: Player = null

func _on_body_entered(body: Node3D) -> void:
	Global.player_stats["third_level_finished"]=true
	player = get_tree().get_first_node_in_group("player")
	Global.player_stats["max_hp"] = player.max_hp
	Global.player_stats["current_hp"] = player.current_hp 
	Global.player_stats["dmg_bonus"] = player.dmg_bonus  
	Global.player_stats["money"] = player.money 
	Global.player_stats["level"] = player.level  
	Global.player_stats["exp_points"] = player.exp_points 
	Global.player_stats["weapons"] = player.weapons
	Global.player_stats["current_weapon_index"] = player.current_weapon_index
	get_tree().change_scene_to_file("res://scenes/places/dungeon/FinalLevel.tscn")
	Global.player_stats["current_position"] = Vector3(1, 1, 2)
