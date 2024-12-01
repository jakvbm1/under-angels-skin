class_name PlayerHurtbox
extends Area3D

func _init() -> void:
	collision_layer = 0
	collision_mask = 32

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: EnemyHitbox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
