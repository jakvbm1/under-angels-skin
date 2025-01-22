extends CharacterBody3D

var player
var state_machine

@onready var hp_label = $Label3D
@onready var anim_tree = $AnimationTree
@onready var gun_barrel = $PowerGun/RayCast3D
@onready var nav_agent = $NavigationAgent3D
@onready var hit_particles: GPUParticles3D = $GPUParticles3D
@onready var death_particles: GPUParticles3D = $GPUParticles3D2

var strength: int = 1

@export var SPEED: float = 2.0 * strength
@export var ATTACK_COOLDOWN: float = 3.0 # in seconds
@export var WALK_RANGE: float = 10.0 * strength
@export var ATTACK_RANGE: float = 5.0
@export var ATTACK_DAMAGE: float = 10.0 * strength
@export var EXP: int = 700

@export var HP = 150
var cooldown = 0.0

var knockback_velocity: Vector3 = Vector3.ZERO
var knockback_timer: float = 0.0
@export var KNOCKBACK_DURATION: float = 0.1
var isKnockback = false

# for projectiles
var bullet = load("res://scenes/weapons/bullet.tscn")
var instance


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if get_node("..").name == "DungeonLevelTwo": strength=2
	anim_tree.active = true
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("player")
	hp_label.text = "HP: %s" % HP
	
	


func _process(delta: float) -> void:
	if !isKnockback:
		# enemy behaviour at every animation state
		match state_machine.get_current_node():
			"idle":
				look_at(Vector3(player.global_position.x, global_position.y,
					player.global_position.z), Vector3.UP, true)
			
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

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= 12.0 * delta
		move_and_slide()
	if knockback_timer > 0.0:
		knockback_timer -= delta
		velocity += knockback_velocity
		move_and_slide()
	else:
		knockback_velocity = Vector3.ZERO
		isKnockback = false

func update_animation_parameters():
	var distance = global_position.distance_to(player.global_position)
	
	if distance < ATTACK_RANGE:
		if cooldown >= ATTACK_COOLDOWN:
			anim_tree["parameters/conditions/attack"] = true
			anim_tree["parameters/conditions/walk"] = false
			anim_tree["parameters/conditions/idle"] = false
		else:
			anim_tree["parameters/conditions/attack"] = false
			anim_tree["parameters/conditions/walk"] = false
			anim_tree["parameters/conditions/idle"] = true
	
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
		# on death
		hp_label.text = "HP: 0"
		player.money += get_gold()
		player.exp_points += EXP
		anim_tree["parameters/conditions/death"] = true
		death_particles.emitting = true
		await get_tree().create_timer(1.0).timeout
		queue_free()
	hit_particles.emitting = true

func get_gold():
	var rng = RandomNumberGenerator.new()
	var money = rng.randi_range(100,1000)
	return money

func take_knockback(knockback: float) -> void:
	isKnockback = true
	var knockback_direction = (global_transform.origin - nav_agent.get_next_path_position()).normalized()
	knockback_velocity = knockback_direction * knockback
	knockback_timer = KNOCKBACK_DURATION

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
