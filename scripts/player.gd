class_name Player
extends CharacterBody3D

var enemy
const SPEED = 5.0
const ACCELERATION = 0.1
const DECELERATION = 0.25
const JUMP_VELOCITY = 4.5
const DASH_MULTI = 100
const REGEN = 2
const DASH_COOLDOWN = 3
const ATTACK_DAMAGE = 25

var max_hp = 100.0
var current_hp = 10.0
var last_dash = 0.0

# signal for red color on the camera
signal player_hit

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var sprite_3d: Sprite3D = $Neck/Camera3D/Sprite3D
@onready var spot_light_3d: SpotLight3D = $Neck/SpotLight3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Global.player = self

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.006)
			camera.rotate_x(-event.relative.y * 0.006)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
			spot_light_3d.rotate_x(-event.relative.y * 0.006)
			spot_light_3d.rotation.x = clamp(spot_light_3d.rotation.x, deg_to_rad(-30), deg_to_rad(60))

func dash():
	if last_dash > 0 :
		var dash_vector = (sprite_3d.global_transform.origin - camera.global_transform.origin).normalized()*DASH_MULTI * last_dash / 3
		#velocity =  Vector3(dash_vector.x, dash_vector.y * 0.25, dash_vector.z)
		velocity = velocity.lerp(Vector3(dash_vector.x, dash_vector.y * 0.17, dash_vector.z), 0.5)
		last_dash = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#if Input.is_action_just_pressed("attack"):
		#animation_player.play("attack")
	
	if Input.is_action_just_pressed("dash"):
		dash()

func update_gravity(delta) -> void:
	velocity += get_gravity() * delta

func update_input(speed: float, acceleration: float, deceleration: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (neck.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

func update_velocity() -> void:
	move_and_slide()

func _process(delta: float) -> void:
	
	if last_dash < DASH_COOLDOWN:
		last_dash += delta
	
	if current_hp < max_hp:
		current_hp += REGEN * delta

func take_damage(damage: int) -> void:
	emit_signal("player_hit")
	if current_hp > 0:
		current_hp -= damage

# after attack animation
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		animation_player.play("idle")
