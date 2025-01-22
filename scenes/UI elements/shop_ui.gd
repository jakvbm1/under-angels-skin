extends Control

@onready var list_node = get_node("ItemList")
@onready var funds = get_node("Label2")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	list_node.add_item("HP bonus            +10%     1000 gold")
	list_node.add_item("Attack bonus     +10%     1000 gold")
	list_node.add_item("Speed bonus      +10%     1000 gold")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	funds.text="Funds: " + str(Global.player_stats["money"])




func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index==0:
		if Global.player_stats["money"]>=1000:
			Global.player_stats["money"]-=1000
			Global.player_stats["max_hp"] *= 1.1
			
	if index==1:
		if Global.player_stats["money"]>=1000:
			Global.player_stats["money"]-=1000
			Global.player_stats["dmg_bonus"]+=0.1
			
	if index==2:
		if Global.player_stats["money"]>=1000:
			Global.player_stats["money"]-=1000
			Global.player_stats["speed_bonus"] +=0.1


func _on_button_pressed() -> void:
	visible=false
