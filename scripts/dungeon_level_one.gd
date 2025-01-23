extends Node

@onready var player = $Player


# for enemies to know player location on map
func _physics_process(_delta: float) -> void:
	get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)

func _ready() -> void:
	if (Global.player_stats["first_level_finished"]):
		var root = get_tree().current_scene
		for node in root.get_children():
			if ("enemy" in node.name||  "Boss" in node.name ):
				root.remove_child(node)
