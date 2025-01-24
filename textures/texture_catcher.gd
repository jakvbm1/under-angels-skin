extends Node3D

@onready var sub_viewport = $SubViewport

@export var snapshot_name: String

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	var img = sub_viewport.get_viewport().get_texture().get_image()
	var image_path = "res://textures/%s.png" % snapshot_name
	img.save_png(image_path)
