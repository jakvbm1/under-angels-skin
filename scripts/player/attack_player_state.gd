class_name AttackPlayerState
extends PlayerMovementState

@export var SPEED: float = 5.0
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25

func enter():
	ANIMATION.play("attack")
	ANIMATION.queue("attack_reset")

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	#if Input.is_action_just_pressed("jump"):
		#transition.emit("JumpPlayerState")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_reset":
		transition.emit("IdlePlayerState")
