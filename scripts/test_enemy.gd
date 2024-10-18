extends CharacterBody3D
var player
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D


const SPEED = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 5
	print(player.position)
	print(position)
	position.x = position.x + (player.position.x - position.x)*0.1*delta
	position.z = position.z + (player.position.z - position.z)*0.1*delta
