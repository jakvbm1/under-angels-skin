extends Label
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_theme_color_override("font_color", Color(1, 1, 0))
	player = get_tree().get_first_node_in_group("player")
	text = str(player.money) +" gold"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = str(player.money) +" gold"
