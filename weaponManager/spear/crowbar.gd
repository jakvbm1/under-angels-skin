extends Node3D

@onready var player: Player = null
@onready var pick_label: Label = $Label

@export var pick_up_distance: float = 2.0

func _ready() -> void:
	pick_label.visible = false
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	var distance_to_player = global_transform.origin.distance_to(player.global_transform.origin)
	
	if distance_to_player<=pick_up_distance:
		pick_label.visible = true
		if Input.is_action_just_pressed("interact"):
			#dodaj bron graczowi
			queue_free()
	else:
		pick_label.visible = false
