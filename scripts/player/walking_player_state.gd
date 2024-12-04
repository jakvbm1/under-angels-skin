class_name WalkingPlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIM_SPEED: float = 2.2

func enter():
	ANIMATION.play("walking")

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	#set_animation_speed(PLAYER.velocity.length())
	
	if Input.is_action_just_pressed("attack"):
		transition.emit("AttackPlayerState")
	
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)
