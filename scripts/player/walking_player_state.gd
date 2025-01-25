class_name WalkingPlayerState
extends PlayerMovementState

@export var SPEED: float = 5 * (Global.player_stats["speed_bonus"])
@export var ACCELERATION: float = 0.1
@export var DECELERATION: float = 0.25
@export var TOP_ANIM_SPEED: float = 2.2

@onready var audio: AudioStreamPlayer3D = $"../../WalkingSound"
@onready var tavern_sound = load("res://assets/soundEffects/walking/woodWalk.wav")
@onready var level1_sound = load("res://assets/soundEffects/walking/brickWalk.wav")
@onready var level2_sound = load("res://assets/soundEffects/walking/brickWalk.wav")
@onready var level3_sound = load("res://assets/soundEffects/walking/metalWalk.wav")
@onready var level4_sound = load("res://assets/soundEffects/walking/fleshWalk.wav")

func enter():
	var level = get_node("../../..").name
	print(level)
	match level:
		"Tavern":
			audio.stream = tavern_sound
			audio.play()
		"DungeonLevelOne":
			audio.stream = level1_sound
			audio.play()
		"DungeonLevelTwo":
			audio.stream = level2_sound
			audio.play()
		"DungeonLevelThree":
			audio.stream = level3_sound
			audio.play()
		"FinalLevel":
			audio.stream = level4_sound
			audio.play()

func update(delta):
	PLAYER.update_gravity(delta)
	PLAYER.update_input(SPEED, ACCELERATION, DECELERATION)
	PLAYER.update_velocity()
	
	#set_animation_speed(PLAYER.velocity.length())
	
	#if Input.is_action_just_pressed("attack"):
		#transition.emit("AttackPlayerState")
	
	if PLAYER.velocity.length() == 0.0:
		transition.emit("IdlePlayerState")
	
	if Input.is_action_just_pressed("ui_accept") and PLAYER.is_on_floor():
		transition.emit("JumpPlayerState")
	
	if Input.is_action_just_pressed("dash"):
		transition.emit("DashPlayerState")

func set_animation_speed(spd):
	var alpha = remap(spd, 0.0, SPEED, 0.0, 1.0)
	ANIMATION.speed_scale = lerp(0.0, TOP_ANIM_SPEED, alpha)

func exit():
	audio.stop()
