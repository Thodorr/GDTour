@tool
extends "res://addons/godot_tours/gdtour_metadata.gd"


func _init() -> void:
	open_welcome_menu_automatically = true
	register_tour(
		"test_tour",
		"Test Tour",
		"res://tours/test_tour/test_tour.gd",
		true,
		false
	)
