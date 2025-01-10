class_name EnemyHurtbox
extends Area3D

func _init() -> void:
	collision_layer = 0
	collision_mask = 16

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(hitbox: PlayerHitbox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage * Global.player.dmg_bonus)
	
	if owner.has_method("take_knockback"):
		owner.take_knockback(hitbox.knockback)
