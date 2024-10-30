extends CharacterBody3D
var player


const SPEED = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var distance = player.position.distance_to(position)

	if distance < 10 and is_on_floor() and distance > 2:
		#print('gonie cie')
		position.x = move_toward(position.x, player.position.x, delta)
		position.z = move_toward(position.z, player.position.z, delta)
		move_and_slide()
		# enemy looking at player constantly
		look_at(Vector3(player.global_transform.origin.x, 0, player.global_transform.origin.z), Vector3.UP, true)
		self.rotation_degrees.x = 0
		self.rotation_degrees.z = 0
		#print(player.position)
		
	#else:
		#print('nie gonie')
	move_and_slide()
