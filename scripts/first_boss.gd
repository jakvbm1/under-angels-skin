extends CharacterBody3D

var player
var state_machine

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

@export var SPEED: float = 3.8
@export var WALK_RANGE: float = 10.0
@export var ATTACK_RANGE: float = 1.5
@export var EXP: int = 800
@export var HP: float = 1000

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	anim_tree.active = true
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	match state_machine.get_current_node():
		"idle":
			var distance = global_position.distance_to(player.global_position)
			
			if distance < WALK_RANGE:
				anim_tree["parameters/conditions/fight_started"] = true
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
		
		"spin":
			anim_tree["parameters/conditions/spin"] = false
		
		"aoe":
			anim_tree["parameters/conditions/aoe"] = false
	
	# animation conditions
	update_animation_parameters()

func update_animation_parameters():
	var distance = global_position.distance_to(player.global_position)
	var current_anim = state_machine.get_current_node()
	
	if distance < ATTACK_RANGE and not (current_anim == "slash" or current_anim == "spin"):
		var attacks = ["slash", "spin"]
		var weights = PackedFloat32Array([1, 0.3])
		var attack = attacks[rng.rand_weighted(weights)]
		anim_tree["parameters/conditions/" + attack] = true

# get player location from the map
func update_target_location(target_location):
	nav_agent.target_position = target_location
