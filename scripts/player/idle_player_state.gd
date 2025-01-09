class_name IdlePlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter():
	pass

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	if PLAYER.velocity.length() > 0.0 and PLAYER.is_on_floor():
		transition.emit("WalkingPlayerState")
	
	#if Input.is_action_just_pressed("attack"):
	#	transition.emit("AttackPlayerState")
	
	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	
	#if Input.is_action_just_pressed("dash"):
		#transition.emit("DashPlayerState")
