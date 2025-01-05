extends AnimatableBody3D

@export var speed = 1
@export var first_pos = -15.0
@export var last_pos = -21.0
var is_back = false

var pos = first_pos
func _physics_process(delta: float) -> void:
	if !is_back:
		pos -= speed
		if pos <= last_pos:
			is_back = true
	else:
		pos += speed
		if pos >= first_pos:
			is_back = false
	
	position.z = pos
