extends Node

@onready var player = $Player
@onready var hit_rect = $HitScreen

# for enemies to know player location on map
func _physics_process(_delta: float) -> void:
	get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)
