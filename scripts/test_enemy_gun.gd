extends CharacterBody3D

var player

@onready var hp_label = $Label3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
#@onready var gun_anim = $PowerGun/AnimationPlayer
@onready var gun_barrel = $PowerGun/RayCast3D

var bullet = load("res://scenes/weapons/bullet.tscn")
var instance

var hp = 200
const SPEED = 100
var isAttacking = false
var cooldown = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hp_label.text = "HP: %s" % hp

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var distance = player.position.distance_to(position)
	cooldown += delta
	
	if !isAttacking:
		if distance < 10 and is_on_floor() and distance >= 1.5:
			animation_player.play("walk")
			#print('gonie cie')
			position.x = move_toward(position.x, player.position.x, delta)
			position.z = move_toward(position.z, player.position.z, delta)
			# enemy looking at player constantly
			look_at(Vector3(player.global_transform.origin.x, 0, player.global_transform.origin.z), Vector3.UP, true)
			self.rotation_degrees.x = 0
			self.rotation_degrees.z = 0
			move_and_slide()
			if (cooldown > 2.5):
				cooldown = 0
				isAttacking = true
				animation_player.play("gun_aim")
		else:
			animation_player.play("idle")
			
		move_and_slide()

func takeDamage(damage: int) -> void:
	hp -= damage
	if hp > 0:
		hp_label.text = "HP: %s" % hp
	else:
		queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "gun_aim":
		#bullet creation
		instance = bullet.instantiate()
		instance.position = gun_barrel.global_position
		instance.transform.basis = gun_barrel.global_transform.basis
		get_parent().add_child(instance)
		
		animation_player.play("gun_down")
	
	if anim_name == "gun_down":
		isAttacking = false
		
