extends Area3D

@onready var front_wall: StaticBody3D = $"../bossFrontFog"
@onready var front_wall_collision: CollisionShape3D = $"../bossFrontFog/CollisionShape3D"
@onready var back_wall: StaticBody3D = $"../bossBackFog"
@onready var back_wall_collision: CollisionShape3D = $"../bossBackFog/CollisionShape3D"

@onready var child_collision: CollisionShape3D = $CollisionShape3D

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		back_wall.visible = true
		front_wall.visible = true
		front_wall_collision.disabled = false
		back_wall_collision.disabled = false
		child_collision.disabled = true


func _on_first_boss_boss_death() -> void:
	back_wall.visible = false
	front_wall.visible = false
	front_wall_collision.disabled = true
	back_wall_collision.disabled = true
