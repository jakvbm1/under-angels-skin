extends AnimatableBody3D

# Variables
@export var open_distance: float = 2.0  # Distance in meters to open the door
@export var animation_player_path: String = "AnimationPlayer"  # Path to the AnimationPlayer node
@export var open_animation_name: String = "open"  # Name of the open animation
@export var close_animation_name: String = "close"  # Name of the close animation
var is_open: bool = false  # Tracks if the door is open

# References
@onready var player: Player = null
@onready var animation_player: AnimationPlayer = null
@onready var root_node: Node3D = self  # Reference to the root Node3D


func _ready():
	# Find the player node (adjust the path as needed for your scene)
	player = get_tree().get_first_node_in_group("player")

	# Get the AnimationPlayer node
	animation_player = $AnimationPlayer

	if not animation_player:
		push_error("AnimationPlayer node not found at path: %s" % animation_player_path)

func _process(delta: float):
	if not player or not animation_player:
		return

	# Calculate distance between player and door
	var distance_to_player = root_node.global_transform.origin.distance_to(player.global_transform.origin)


	# Check if player is within range and presses "F" key
	if distance_to_player <= open_distance and Input.is_action_just_pressed("interact"):
		toggle_door()

func toggle_door():
	print("togglowanko")
	if is_open:
		animation_player.play(close_animation_name)
	else:
		animation_player.play(open_animation_name)

	is_open = not is_open
