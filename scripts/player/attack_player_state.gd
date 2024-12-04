class_name AttackPlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter():
	ANIMATION.play("attack")
	await ANIMATION.animation_finished
	ANIMATION.play("idle")
	transition.emit("IdlePlayerState")

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
