extends CharacterBody3D

var player
var state_machine

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@onready var hit_particles: GPUParticles3D = $GPUParticles3D_hit
@onready var death_particles: GPUParticles3D = $GPUParticles3D_death
var hp_bar: ProgressBar
var name_label: Label

@export var SPEED: float = 3.8
@export var ATTACK_RANGE: float = 1.5
@export var EXP: int = 2000
@export var GOLD: int = 2000
@export var MAX_HP: float = 1000
var HP: float

var rng = RandomNumberGenerator.new()

var first_aoe: bool = true
var second_aoe: bool = true
var third_aoe: bool = true

signal boss_death

func _ready() -> void:
	anim_tree.active = true
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("player")
	hp_bar = player.get_node("PlayersUi/ProgressBar")
	name_label = player.get_node("PlayersUi/ProgressBar/Label")
	hp_bar.max_value = MAX_HP
	HP = MAX_HP
	name_label.text = "The Gatekeeper"

func _process(delta: float) -> void:
	if hp_bar.visible:
		hp_bar.value = HP
	
	match state_machine.get_current_node():
		"walk":
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED
			velocity = velocity.move_toward(new_velocity, 0.25)
			
			# to be rotated at player
			look_at(Vector3(player.global_position.x, global_position.y,
				player.global_position.z), Vector3.UP, true)
			
			# apply enemy movement
			move_and_slide()
		
		"slash":
			anim_tree["parameters/conditions/slash"] = false
			
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED * 0.4
			velocity = velocity.move_toward(new_velocity, 0.25)
			
			# to be rotated at player
			look_at(Vector3(player.global_position.x, global_position.y,
				player.global_position.z), Vector3.UP, true)
			
			# apply enemy movement
			move_and_slide()
		
		"spin":
			anim_tree["parameters/conditions/spin"] = false
		
		"aoe":
			anim_tree["parameters/conditions/aoe"] = false
	
	# animation conditions
	update_animation_parameters()

func update_animation_parameters():
	var distance = global_position.distance_to(player.global_position)
	var current_anim = state_machine.get_current_node()
	
	if distance < ATTACK_RANGE and not (current_anim == "slash" or current_anim == "spin" or current_anim == "aoe"):
		if HP <= 0.75 * MAX_HP and first_aoe:
			anim_tree["parameters/conditions/aoe"] = true
			first_aoe = false
		if HP <= 0.5 * MAX_HP and second_aoe:
			anim_tree["parameters/conditions/aoe"] = true
			second_aoe = false
		elif HP <= 0.25 * MAX_HP and third_aoe:
			anim_tree["parameters/conditions/aoe"] = true
			third_aoe = false
		else:
			var attacks = ["slash", "spin"]
			var weights = PackedFloat32Array([1, 0.3])
			var attack = attacks[rng.rand_weighted(weights)]
			anim_tree["parameters/conditions/" + attack] = true

# get player location from the map
func update_target_location(target_location):
	nav_agent.target_position = target_location

func take_damage(damage: int) -> void:
	HP -= damage
	if HP > 0:
		hp_bar.value = HP
	else:
		# on death
		hp_bar.value = 0
		player.money += GOLD
		player.exp_points += EXP
		Global.player_stats["first_level_finished"]=true
		anim_tree["parameters/conditions/death"] = true
		death_particles.emitting = true
		hp_bar.visible = false
		await get_tree().create_timer(3.0).timeout
		queue_free()
		boss_death.emit()
	hit_particles.emitting = true


func _on_area_boss_start_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		anim_tree["parameters/conditions/fight_started"] = true
		hp_bar.visible = true
