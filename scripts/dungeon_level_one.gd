extends Node

@onready var player = $Player
@onready var hit_rect = $HitScreen

# for enemies to know player location on map
func _physics_process(_delta: float) -> void:
	get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)

# show a quick red color on the camera
func _on_player_player_hit() -> void:
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
