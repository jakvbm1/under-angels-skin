class_name PlayerHitbox
extends Area3D

@export var damage := 10

func _init() -> void:
	collision_layer = 16
	collision_mask = 0
