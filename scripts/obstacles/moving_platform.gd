extends AnimatableBody3D

@export var speed = 0.05
@export var first_pos = 0
@export var last_pos = 0
var is_back = false
var is_waiting = false

var pos = position.z
func _physics_process(delta: float) -> void:
	if !is_waiting:
		if !is_back:
			pos -= speed
			if pos <= last_pos:
				is_waiting = true
				await get_tree().create_timer(1).timeout
				is_waiting = false
				is_back = true
		else:
			pos += speed
			if pos >= first_pos:
				is_waiting = true
				await get_tree().create_timer(1).timeout
				is_waiting = false
				is_back = false
		
		position.z = pos
