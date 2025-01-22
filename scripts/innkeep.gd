extends Node3D
@onready var player: Player = null
@export var open_distance:float = 3.0
@onready var talkLabel: Label = $TalkLabel
@onready var ShopUI = $ShopUi
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	talkLabel.visible = false
	ShopUI.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	talkLabel.visible = distance_to_player <= open_distance and not ShopUI.visible
	if distance_to_player<=open_distance:
		if Input.is_action_just_pressed("interact"):
			ShopUI.visible = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
			
			
	else: talkLabel.visible = false
