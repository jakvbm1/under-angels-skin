extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const DASH_MULTI = 50
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var sprite_3d: Sprite3D = $Neck/Camera3D/Sprite3D
@onready var spot_light_3d: SpotLight3D = $Neck/SpotLight3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area3D = $Neck/Camera3D/Weapon/WeaponMesh/Hitbox

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
	var dash_vector = (sprite_3d.global_transform.origin - camera.global_transform.origin).normalized()*DASH_MULTI
	velocity =  Vector3(dash_vector.x, dash_vector.y * 0.25, dash_vector.z)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (neck.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("dash"):
		print('dash')
		dash()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		animation_player.play("attack")
		hitbox.monitoring = true

# after attack animation
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		animation_player.play("idle")
		hitbox.monitoring = false

# when attack animation enters an enemy hitbox
func _on_hitbox_body_entered(body: Node3D) -> void:
	if body.is_in_group("enemy"):
		print("szkielecik dostal")
