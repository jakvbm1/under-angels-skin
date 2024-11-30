extends Node3D

const SPEED = 15.0
const BULLET_DAMAGE = 10

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		if ray.get_collider().is_in_group("player"):
			ray.get_collider().takeDamage(BULLET_DAMAGE)
		queue_free()
