extends Node2D

@onready var draggable_motherboard = $DraggableMotherboard
@onready var complete_button = $CompleteButton

func _ready() -> void:
	# Hide the complete button initially
	if complete_button:
		complete_button.visible = false
		complete_button.pressed.connect(_on_complete_button_pressed)
		
	# Connect the drag-and-drop signal
	if draggable_motherboard:
		draggable_motherboard.installed.connect(_on_motherboard_installed)

func _on_motherboard_installed() -> void:
	print("System Unit Assembly Complete! Revealing Button.")
	complete_button.visible = true

# Inside system_unit_assembly.gd

func _on_complete_button_pressed() -> void:
	# Save progress for putting it in the case
	GlobalState.complete_task("Fix PC: System Unit Installation")
	
	# Transition back to the computer menu instead of the shop
	get_tree().change_scene_to_file("res://scenes/computer_menu.tscn")
