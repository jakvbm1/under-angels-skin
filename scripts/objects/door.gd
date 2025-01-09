extends StaticBody3D


# Variables
@export var open_distance: float = 2.0  # Distance in meters to open the door
var is_open: bool = false  # Tracks if the door is open

# References
@onready var player: Player = null
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio_stream_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	# Find the player node (adjust the path as needed for your scene)
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float):
	if not player or not animation_player:
		return
	
	# Calculate distance between player and door
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	# Check if player is within range and presses "F" key
	if distance_to_player <= open_distance and Input.is_action_just_pressed("interact"):
		toggle_door()

func toggle_door():
	if not animation_player.is_playing():
		if !is_open:
			animation_player.play("door_open")
			audio_stream_player.play()
		else:
			animation_player.play("door_close")
			audio_stream_player.play()
		
		is_open = not is_open
