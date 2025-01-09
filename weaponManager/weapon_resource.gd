class_name WeaponResource
extends Resource

@export var view_model: PackedScene

## Weapon position in front of player camera

@export var pos: Vector3
@export var rot: Vector3
@export var scale: Vector3 = Vector3(1,1,1)

## Sounds

@export var attack_sound: AudioStream

## Weapon logic

@export var damage: float = 10.0
@export var knockback: float = 0.5
@export var cooldown: float = 0.65

var weapon_manager : WeaponManager

var trigger_down: bool = false :
	set(value):
		if trigger_down != value:
			trigger_down = value
			if trigger_down:
				on_trigger_down()
			else:
				on_trigger_up()

var is_equipped: bool = false :
	set(value):
		if is_equipped != value:
			is_equipped = value
			if is_equipped:
				on_equip()
			else:
				on_unequip()

func on_trigger_down():
	attack()

func on_trigger_up():
	pass

func on_equip():
	pass

func on_unequip():
	pass

func attack():
	weapon_manager.play_sound(attack_sound)
	weapon_manager.play_anim("attack")
	weapon_manager.queue_anim("attack_reset")
