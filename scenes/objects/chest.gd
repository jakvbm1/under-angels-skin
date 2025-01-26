extends Node3D

var empty_chests: Array = []
var is_open: bool = false
@onready var player: Player = null
@onready var openLabel: Label = $"OpenChestLabel"
@onready var closeLabel: Label =  $"CloseChestLabel"
@onready var goldLabel: Label = $"GoldLabel"
@export var open_distance:float = 2.0
@onready var animation_player: AnimationPlayer = $"AnimationPlayer"
@onready var audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	openLabel.visible=false
	closeLabel.visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player or not animation_player:
		return
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance_to_player<=open_distance:
		
		if !is_open: openLabel.visible = true
		if is_open: closeLabel.visible = true
		if Input.is_action_just_pressed("interact"):
			
			toggle_chest()
			if !is_open: closeLabel.visible = false
			if is_open: openLabel.visible = false
	else: 
		openLabel.visible=false
		closeLabel.visible=false
		goldLabel.visible=false
func toggle_chest():
	var chest_number = name.split(" ")[1]
	if not animation_player.is_playing():
		if !is_open:
			animation_player.play("open")
			audio.play()
			if chest_number not in empty_chests:
				goldLabel.add_theme_color_override("font_color", Color(1, 1, 0))

				var money = get_gold()
				goldLabel.text = "+%s gold" %money
				goldLabel.visible=true
				
				player.money+=money
				player.exp_points+=300
				empty_chests.append(chest_number)
		else: 
			animation_player.play("close")
			audio.play()
			
		is_open = not is_open
func get_gold():
	var rng = RandomNumberGenerator.new()
	var money = rng.randi_range(100,1000)
	return money
