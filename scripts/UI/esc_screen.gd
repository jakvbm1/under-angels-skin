extends Control

@onready var back_button = $BackButton
@onready var load_button = $LoadButton
@onready var menu_button = $MenuButton

func _ready():
	back_button.pressed.connect(back)
	load_button.pressed.connect(go_load)
	menu_button.pressed.connect(menu)

func _process(delta: float):
	if(visible):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		back_button.disabled = false
		load_button.disabled = false
		menu_button.disabled = false
		
	else:
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		back_button.disabled = true
		load_button.disabled = true
		menu_button.disabled = true
		
		
func back():
	visible = false
	
func go_load():
	get_tree().change_scene_to_file("res://scenes/UI elements/load_save menu.tscn")
	
func menu():
	get_tree().change_scene_to_file("res://scenes/UI elements/main_menu.tscn")
