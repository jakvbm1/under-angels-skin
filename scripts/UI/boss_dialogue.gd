extends Control

var read: bool = false
@onready var next = $Button
@onready var text_field = $Label
var dialog_counter: int = 0
var dialog_texts = ["So you've come, let me introduce myself...", "I'm Dohrnii, an avatar \nof this land - personification of\n it's soul",
"The insolence of your kind\n brought me to a place where\n I dont have other choice", "I WILL kill you all"]

func _ready():

	text_field.text = dialog_texts[0]
	next.pressed.connect(update_text)
	
func update_text():
	dialog_counter += 1
	print(dialog_counter)
	if dialog_counter <= 3:
		text_field.text = dialog_texts[dialog_counter]
		
	else:
		visible = false
		
	
