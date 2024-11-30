extends Node3D

const SPEED = 15.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D

func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -SPEED) * delta
	if ray.is_colliding():
		queue_free()
