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
				if (get_node("..").name == "DungeonLevelOne"):
					collider.take_damage(10)
				if (get_node("..").name == "DungeonLevelTwo"):
					collider.take_damage(15)
				if (get_node("..").name == "FinalLevel"):
					collider.take_damage(23)
			queue_free()
