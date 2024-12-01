class_name EnemyHitbox
extends Area3D

@export var damage := 10

func _init() -> void:
	collision_layer = 32
	collision_mask = 0
