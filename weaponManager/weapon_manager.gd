class_name WeaponManager
extends Node3D

# weapon swapping logic
var weapons: Array = ["sword", "spear", "katana", "hammer", "crowbar"]
var current_weapon_index: int = 0

func change_weapon(direction: int):
	if weapons.size() > 0:
		current_weapon_index = (current_weapon_index + direction) % weapons.size()
		if current_weapon_index < 0:
			current_weapon_index = weapons.size() - 1
		update_weapon_ui()

func update_weapon_ui():
	if weapons.size() > 0:
		var equipped_weapon: String = weapons[current_weapon_index]
		match equipped_weapon:
			"sword":
				current_weapon = load("res://weaponManager/sword1/sword1.tres")
				weapon_slot.texture = load("res://weaponManager/sword1/sword1.png")
			"spear":
				current_weapon = load("res://weaponManager/spear/spear.tres")
				weapon_slot.texture = load("res://weaponManager/spear/spear.png")
			"katana":
				current_weapon = load("res://weaponManager/katana/katana.tres")
				weapon_slot.texture = load("res://weaponManager/katana/katana.png")
			"hammer":
				current_weapon = load("res://weaponManager/hammer/hammer.tres")
				weapon_slot.texture = load("res://weaponManager/hammer/hammer.png")
			"crowbar":
				current_weapon = load("res://weaponManager/crowbar/crowbar.tres")
				weapon_slot.texture = load("res://weaponManager/crowbar/crowbar.png")

@export var allow_attack: bool = true

@export var current_weapon : WeaponResource :
	set(v):
		if v != current_weapon:
			if current_weapon:
				current_weapon.is_equipped = false
			current_weapon = v;
			if is_inside_tree():
				update_weapon_model()

@export var player: CharacterBody3D
@export var bullet_raycast: RayCast3D

@export var view_model: Node3D

@export var weapon_slot: TextureRect

var current_weapon_view_model: Node3D

var cooldown_timer: float

@onready var audio_stream_player = $AudioStreamPlayer3D

func update_weapon_model() -> void:
	if current_weapon_view_model != null and is_instance_valid(current_weapon_view_model):
		current_weapon_view_model.queue_free()
		current_weapon_view_model.get_parent().remove_child(current_weapon_view_model)
	if current_weapon != null:
		current_weapon.weapon_manager = self
		if view_model and current_weapon.view_model:
			current_weapon_view_model = current_weapon.view_model.instantiate()
			view_model.add_child(current_weapon_view_model)
			current_weapon_view_model.position = current_weapon.pos
			current_weapon_view_model.rotation = current_weapon.rot
			current_weapon_view_model.scale = current_weapon.scale
		current_weapon.is_equipped = true
		cooldown_timer = current_weapon.cooldown

func play_sound(sound: AudioStream):
	if sound:
		if audio_stream_player.stream != sound:
			audio_stream_player.stream = sound
		audio_stream_player.play()

func stop_sounds():
	audio_stream_player.stop()

func play_anim(name: String):
	var anim_player: AnimationPlayer = current_weapon_view_model.get_node_or_null("AnimationPlayer")
	if not anim_player or not anim_player.has_animation(name):
		return
	
	anim_player.seek(0.0)
	anim_player.play(name)

func queue_anim(name: String):
	var anim_player: AnimationPlayer = current_weapon_view_model.get_node_or_null("AnimationPlayer")
	if not anim_player or not anim_player.has_animation(name):
		return
	
	anim_player.queue(name)

func get_anim() -> String:
	var anim_player : AnimationPlayer = current_weapon_view_model.get_node_or_null("AnimationPlayer")
	if not anim_player: return ""
	return anim_player.current_animation

func _unhandled_input(event):
	# weapon changing
	if event.is_action_pressed("weapon1"):
		change_weapon(-1)
	if event.is_action_pressed("weapon2"):
		change_weapon(1)
	if current_weapon and is_inside_tree() and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event.is_action_pressed("attack") and allow_attack:
			current_weapon.trigger_down = true

func _ready() -> void:
	update_weapon_model()

func _process(delta: float) -> void:
	if current_weapon.trigger_down:
		if cooldown_timer > 0:
			cooldown_timer -= delta
		else:
			cooldown_timer = current_weapon.cooldown
			current_weapon.trigger_down = false
