class_name JumpPlayerState
extends PlayerMovementState

@export var SPEED: float = 6.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var JUMP_VELOCITY: float = 4.5
@export_range(0.5, 1.0, 0.01) var INPUT_MULTIPLIER: float = 0.85

func enter():
	PLAYER.velocity.y += JUMP_VELOCITY
	

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED * INPUT_MULTIPLIER, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if PLAYER.is_on_floor():
		transition.emit("IdlePlayerState")
	
	#if Input.is_action_just_pressed("attack"):
		#transition.emit("AttackPlayerState")
	
	if Input.is_action_just_pressed("dash"):
		transition.emit("DashPlayerState")
