extends CharacterBody3D

var player

@onready var hp_label = $Label3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox = $axe/Hitbox
@onready var nav_agent = $NavigationAgent3D

var HP = 200
const SPEED = 2
var isAttacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hp_label.text = "HP: %s" % HP

func _physics_process(delta: float) -> void:
	var distance = player.position.distance_to(position)
	
	if distance < 10 and !isAttacking:
		# dancing, walking, rearranging furniture
		animation_player.play("walk")
		var current_location = global_transform.origin
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * SPEED
		velocity = velocity.move_toward(new_velocity, 0.25)
		
		# to be rotated at player's direction
		look_at(Vector3(player.global_position.x, global_position.y, player.global_position.z), Vector3.UP, true)
		
		# to apply the movement
		move_and_slide()

# get player location from the map
func update_target_location(target_location):
	nav_agent.target_position = target_location

# if player is near (Target Desired Distance value in NavigationAgent properties)
func _on_navigation_agent_3d_target_reached() -> void:
	isAttacking = true
	animation_player.play("attack_melee")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_melee":
		animation_player.play("attack_melee_2")
		hitbox.monitoring = true
	if anim_name == "attack_melee_2":
		hitbox.monitoring = false
		isAttacking = false

func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.takeDamage(20)

func takeDamage(damage: int) -> void:
	HP -= damage
	if HP > 0:
		hp_label.text = "HP: %s" % HP
	else:
		queue_free()
