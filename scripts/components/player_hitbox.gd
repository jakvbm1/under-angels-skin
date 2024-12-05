class_name PlayerHitbox
extends Area3D

@export var damage: int = 10
@export var knockback: float = 0.8

func _init() -> void:
	collision_layer = 16
	collision_mask = 0
