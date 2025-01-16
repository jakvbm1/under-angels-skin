extends Node3D

var unlocked:bool = false
@onready var player: Player = null
@onready var light: OmniLight3D = $OmniLight3D
@onready var activateLabel: Label = $ActivateLabel
@onready var statue = $Angel_Statue_Cube_004/StaticBody3D
@onready var menu =$StatueSelection
@export var open_distance:float = 2.0


func _ready():
	menu.visible = false
	player = get_tree().get_first_node_in_group("player")
	light.visible = unlocked
	activateLabel.visible = false
	
	
	
func _process(delta: float):
	if not player :
		return
	
	# Calculate distance between player and door
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	# Check if player is within range and presses "F" key
	if distance_to_player <= open_distance:
		activateLabel.visible = true
		if Input.is_action_just_pressed("interact"):
			activate_statue()
			
	else: activateLabel.visible = false
func activate_statue():
	if(!unlocked):
		unlocked = true
		light.visible = true
	
	menu.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
