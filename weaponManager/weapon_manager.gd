class_name WeaponManager
extends Node3D

@export var current_weapon: WeaponResource

@export var player: CharacterBody3D
@export var bullet_raycast: RayCast3D

@export var view_model: Node3D

var current_weapon_view_model: Node3D

func update_weapon_model() -> void:
	if current_weapon != null:
		if view_model and current_weapon.view_model:
			current_weapon_view_model = current_weapon.view_model.instantiate()
			view_model.add_child(current_weapon_view_model)
			current_weapon_view_model.position = current_weapon.pos
			current_weapon_view_model.rotation = current_weapon.rot
			current_weapon_view_model.scale = current_weapon.scale

func _ready() -> void:
	update_weapon_model()
