extends Node3D

const SPEED = 15.0

@onready var mesh = $MeshInstance3D
@onready var ray = $RayCast3D
@export var distance = 10
@onready var time_exist = 10
var start = 0

func _process(delta: float) -> void:
	start += delta
	position += transform.basis * Vector3(0, -2/distance*SPEED, SPEED) * delta
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider.is_in_group("player"):
			if collider.has_method("take_damage"):
				collider.take_damage(60)
				queue_free()
	
	if start > time_exist:
		queue_free()
