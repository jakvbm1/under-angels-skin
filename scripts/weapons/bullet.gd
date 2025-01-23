extends Node3D

const SPEED = 27.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.is_in_group("player"):
			if collider.has_method("take_damage"):
				collider.take_damage(10)
		queue_free()
