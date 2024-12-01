extends CharacterBody3D

var player
var state_machine

@onready var hp_label = $Label3D
@onready var anim_tree = $AnimationTree
@onready var gun_barrel = $PowerGun/RayCast3D
@onready var nav_agent = $NavigationAgent3D

const SPEED = 2.0
const ATTACK_COOLDOWN = 3.0 # in seconds
const WALK_RANGE = 10.0
const ATTACK_RANGE = 5.0
const ATTACK_DAMAGE = 10

var HP = 150
var cooldown = 0.0

# for projectiles
var bullet = load("res://scenes/weapons/bullet.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_tree.active = true
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("player")
	hp_label.text = "HP: %s" % HP


func _process(delta: float) -> void:
	# enemy behaviour at every animation state
	match state_machine.get_current_node():
		"walk":
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED
			velocity = velocity.move_toward(new_velocity, 0.25)
			
			# to be rotated at walking direction
			look_at(Vector3(player.global_position.x + velocity.x, global_position.y,
				player.global_position.z + velocity.z), Vector3.UP, true)
			
			# apply enemy movement
			move_and_slide()
	
	# animation conditions
	update_animation_parameters()
	
	if cooldown < ATTACK_COOLDOWN:
		cooldown += delta


func update_animation_parameters():
	var distance = global_position.distance_to(player.global_position)
	
	if distance < ATTACK_RANGE and cooldown >= ATTACK_COOLDOWN:
		anim_tree["parameters/conditions/attack"] = true
		anim_tree["parameters/conditions/walk"] = false
		anim_tree["parameters/conditions/idle"] = false
	
	elif distance < WALK_RANGE:
		anim_tree["parameters/conditions/attack"] = false
		anim_tree["parameters/conditions/walk"] = true
		anim_tree["parameters/conditions/idle"] = false
	
	else:
		anim_tree["parameters/conditions/attack"] = false
		anim_tree["parameters/conditions/walk"] = false
		anim_tree["parameters/conditions/idle"] = true

# get player location from the map
func update_target_location(target_location):
	nav_agent.target_position = target_location


func take_damage(damage: int) -> void:
	HP -= damage
	if HP > 0:
		hp_label.text = "HP: %s" % HP
	else:
		queue_free()


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	# shoot a projectile when aiming animation is finished
	if anim_name == "gun_aim":
		# bullet creation
		instance = bullet.instantiate()
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		get_parent().add_child(instance)
		
		# attack cooldown reset
		cooldown = 0.0
