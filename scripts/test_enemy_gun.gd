extends CharacterBody3D

var player

@onready var hp_label = $Label3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var gun_barrel = $PowerGun/RayCast3D
@onready var nav_agent = $NavigationAgent3D

var HP = 200
const SPEED = 2
var isAttacking = false
var cooldown = 0.0

# for projectiles
var bullet = load("res://scenes/weapons/bullet.tscn")
var instance

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
		
		# enemy looking at player constantly
		look_at(Vector3(player.global_transform.origin.x, 0, player.global_transform.origin.z), Vector3.UP, true)
		self.rotation_degrees.x = 0
		self.rotation_degrees.z = 0
		
		move_and_slide()
	
	cooldown += delta

func update_target_location(target_location):
	nav_agent.target_position = target_location

# if player is near (Target Desired Distance value in NavigationAgent properties)
func _on_navigation_agent_3d_target_reached() -> void:
	if (cooldown > 3):
		isAttacking = true
		cooldown = 0
		animation_player.play("gun_aim")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	# when enemy finishes aiming, then shoot a projectile
	if anim_name == "gun_aim":
		#bullet creation
		instance = bullet.instantiate()
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		get_parent().add_child(instance)
		
		animation_player.play("gun_down")
	
	# to start walking after an attack
	if anim_name == "gun_down":
		isAttacking = false

func takeDamage(damage: int) -> void:
	HP -= damage
	if HP > 0:
		hp_label.text = "HP: %s" % HP
	else:
		queue_free()
