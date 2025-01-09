extends Node3D

var unlocked:bool = false
@onready var player: Player = null
@onready var light: OmniLight3D = $OmniLight3D
@onready var statue = $Angel_Statue_Cube_004/StaticBody3D
@export var open_distance:float = 2.0


func _ready():
	player = get_tree().get_first_node_in_group("player")
	light.visible = unlocked
	
func _process(delta: float):
	if not player :
		return
	
	# Calculate distance between player and door
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	# Check if player is within range and presses "F" key
	if distance_to_player <= open_distance and Input.is_action_just_pressed("interact"):
		activate_statue()
		save()
		
func activate_statue():
	if(!unlocked):
		unlocked = true
		light.visible = true
		
func save():
	print('not implemented yet ;p')
