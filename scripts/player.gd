class_name Player
extends CharacterBody3D

const REGEN = 2
const DASH_COOLDOWN = 3

@export var max_hp = 100.0
@export var current_hp = 10.0
@export var last_dash = 0.0
@export var gravity = 12.0

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var sprite_3d: Sprite3D = $Neck/Camera3D/Sprite3D
@onready var spot_light_3d: SpotLight3D = $Neck/SpotLight3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_rect = $PlayersUi/HitScreen

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

func update_gravity(delta) -> void:
	velocity.y -= gravity * delta

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
	Global.debug.add_property("Velocity", "%.2f" % velocity.length(), 1)
	
	if last_dash < DASH_COOLDOWN:
		last_dash += delta
	
	if current_hp < max_hp:
		current_hp += REGEN * delta

func take_damage(damage: int) -> void:
	# for red screen
	hit_rect.visible = true
	await get_tree().create_timer(0.2).timeout
	hit_rect.visible = false
	
	if current_hp > 0:
		current_hp -= damage
