class_name Player
extends CharacterBody3D

const REGEN: float = 2.0
const DASH_COOLDOWN: float = 3.0

@export var last_dash: float = 0.0
@export var gravity: float = 12.0

@export var max_hp: float 
@export var current_hp: float 
@export var dmg_bonus: float 

@export var money: int 
@export var level: int :
	set(value):
		level = value
		max_hp += value * 20
		dmg_bonus +=  float(level) / 10
@export var exp_points: float :
	set(value):
		exp_points = value
		if exp_points >= 500.0 * level:
			level += 1

@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
@onready var sprite_3d: Sprite3D = $Neck/Camera3D/Sprite3D
@onready var spot_light_3d: SpotLight3D = $Neck/SpotLight3D
@onready var hit_rect = $PlayersUi/HitScreen
@onready var esc_screen = $EscScreen


func _ready() -> void:
	max_hp = Global.player_stats["max_hp"]
	current_hp = Global.player_stats["current_hp"]
	dmg_bonus = Global.player_stats["dmg_bonus"]
	money = Global.player_stats["money"]
	level = Global.player_stats["level"]
	exp_points = Global.player_stats["exp_points"]
	self.position = Global.player_stats["current_position"]
	esc_screen.visible = false
	
	

func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed('ui_cancel'):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		var root = get_tree().current_scene
		for node in root.get_children():
			if ("enemy" in node.name||  "Boss" in node.name ):
				node.set_process(false)
		esc_screen.visible = true
		
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			neck.rotate_y(-event.relative.x * 0.006)
			camera.rotate_x(-event.relative.y * 0.006)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50), deg_to_rad(75))
			spot_light_3d.rotate_x(-event.relative.y * 0.006)
			spot_light_3d.rotation.x = clamp(spot_light_3d.rotation.x, deg_to_rad(-50), deg_to_rad(75))

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
	Global.debug.add_property("Gold", money, 3)
	Global.debug.add_property("Level", level, 4)
	Global.debug.add_property("Exp", exp_points, 5)
	Global.debug.add_property("dmg bonus", dmg_bonus, 6)
	
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
		
	if current_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/UI elements/death_screen.tscn")
