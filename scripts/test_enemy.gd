extends CharacterBody3D

var player

@onready var hp_label = $Label3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox = $axe/Hitbox
var hp = 200
const SPEED = 100
var isAttacking = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	hp_label.text = "HP: %s" % hp

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var distance = player.position.distance_to(position)
	
	if !isAttacking:
		if distance < 10 and is_on_floor() and distance >= 1.5:
			#print('gonie cie')
			position.x = move_toward(position.x, player.position.x, delta)
			position.z = move_toward(position.z, player.position.z, delta)
			move_and_slide()
			animation_player.play("walk")
			# enemy looking at player constantly
			look_at(Vector3(player.global_transform.origin.x, 0, player.global_transform.origin.z), Vector3.UP, true)
			self.rotation_degrees.x = 0
			self.rotation_degrees.z = 0
			#print(player.position)
		elif distance <= 1.5:
			animation_player.play("attack_melee")
			isAttacking = true
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
	if anim_name == "attack_melee":
		animation_player.play("attack_melee_2")
		hitbox.monitoring = true
	if anim_name == "attack_melee_2":
		hitbox.monitoring = false
		isAttacking = false

func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player.takeDamage(20)
