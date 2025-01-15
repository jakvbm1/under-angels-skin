extends CharacterBody3D
var player
var state_machine

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
var hp_bar: ProgressBar
var name_label: Label

@export var SPEED: float = 5.5
@export var ATTACK_RANGE: float = 1.5
@export var EXP: int = 5000
@export var GOLD: int = 10000
@export var MAX_HP: float = 5000
var HP: float

var rng = RandomNumberGenerator.new()

signal boss_death

func _ready() -> void:
	anim_tree.active = true
	state_machine = anim_tree.get("parameters/playback")
	player = get_tree().get_first_node_in_group("player")
	hp_bar = player.get_node("PlayersUi/ProgressBar")
	name_label = player.get_node("PlayersUi/ProgressBar/Label")
	hp_bar.max_value = MAX_HP
	HP = MAX_HP
	name_label.text = "Dohrnii"
	#hp_bar.visible = true

func _process(delta: float) -> void:
	if hp_bar.visible:
		hp_bar.value = HP
	
	match state_machine.get_current_node():
		"walk":
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED
			velocity = velocity.move_toward(new_velocity, 0.4)
			
			# to be rotated at player
			look_at(Vector3(player.global_position.x, global_position.y,
				player.global_position.z), Vector3.UP, true)
			
			# apply enemy movement
			move_and_slide()
			
		"punch_1":
			var current_location = global_transform.origin
			var next_location = nav_agent.get_next_path_position()
			var new_velocity = (next_location - current_location).normalized() * SPEED
			velocity = velocity.move_toward(new_velocity, 2)
			
			# to be rotated at player
			look_at(Vector3(player.global_position.x, global_position.y,
				player.global_position.z), Vector3.UP, true)
			
			# apply enemy movement
			move_and_slide()
			
			
		
	
	# animation conditions
	update_animation_parameters()

func update_animation_parameters():
	var distance = global_position.distance_to(player.global_position)
	var current_anim = state_machine.get_current_node()
	
	if distance < 10 and distance > 1.25:
		anim_tree["parameters/conditions/punch"] = false
		anim_tree["parameters/conditions/start"] = true
		anim_tree["parameters/conditions/walk"] = true
		hp_bar.visible = true
		
	else:
		anim_tree["parameters/conditions/punch"] = true



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
		anim_tree["parameters/conditions/dead"] = true
		hp_bar.visible = false
		await get_tree().create_timer(3.0).timeout
		queue_free()
		boss_death.emit()
