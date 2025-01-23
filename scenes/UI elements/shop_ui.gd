extends Control

@onready var list_node = get_node("ItemList")
@onready var funds = get_node("Label2")
@onready var player: Node = null
@onready var hp_price:int = Global.player_stats["max_hp"] * 10
@onready var speed_price:int = Global.player_stats["speed_bonus"] * 1100
@onready var dmg_price:int =  Global.player_stats["dmg_bonus"] * 900
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	list_node.add_item("HP bonus            +10%     " + str(hp_price) + " gold")
	list_node.add_item("Attack bonus     +10%     "+str(speed_price)+ "gold")
	list_node.add_item("Speed bonus      +10%     " + str(dmg_price)+ "gold")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	funds.text="Funds: " + str(Global.player_stats["money"])




func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index==0:
		if Global.player_stats["money"]>=hp_price:
			Global.player_stats["money"]-=hp_price
			Global.player_stats["max_hp"] *= 1.1
			player.reload_values()
			hp_price = Global.player_stats["max_hp"] * 10
			list_node.set_item_text(0,"HP bonus            +10%     " + str(hp_price) + " gold") 
			
	if index==1:
		if Global.player_stats["money"]>=dmg_price:
			Global.player_stats["money"]-=dmg_price
			Global.player_stats["dmg_bonus"]+=0.1
			player.reload_values()
			dmg_price = Global.player_stats["dmg_bonus"] * 1100
			list_node.set_item_text(1,"Attack bonus     +10%     "+str(dmg_price)+ "gold")
			
	if index==2:
		if Global.player_stats["money"]>=speed_price:
			Global.player_stats["money"]-=speed_price
			Global.player_stats["speed_bonus"] +=0.1
			player.reload_values()
			speed_price =  Global.player_stats["speed_bonus"] * 900
			list_node.set_item_text(2,"Speed bonus      +10%     " + str(speed_price)+ "gold")


func _on_button_pressed() -> void:
	visible=false
