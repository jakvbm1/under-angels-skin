extends Node3D
@onready var player: Player = null
@onready var label = $Label
@export var interaction_distance: float = 2.0
func _ready():
	player = get_tree().get_first_node_in_group("player")
	label.visible = false
	
func _process(delta: float):
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance_to_player < interaction_distance:
		label.visible = true
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://scenes/places/dungeon/dungeon_level_one.tscn")
		
	else:
		label.visible = false
	
