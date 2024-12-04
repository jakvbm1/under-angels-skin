class_name DashPlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var DASH_MULTIPLIER: float = 100.0

func enter():
	if PLAYER.last_dash > 0 :
		var dash_vector = (PLAYER.sprite_3d.global_transform.origin -
			PLAYER.camera.global_transform.origin).normalized() * DASH_MULTIPLIER * PLAYER.last_dash / 3
		#velocity =  Vector3(dash_vector.x, dash_vector.y * 0.25, dash_vector.z)
		PLAYER.velocity = PLAYER.velocity.lerp(Vector3(dash_vector.x, dash_vector.y * 0.17, dash_vector.z), 0.5)
		PLAYER.last_dash = 0

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if Input.is_action_just_released("dash"):
		transition.emit("IdlePlayerState")
