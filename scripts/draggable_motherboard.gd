extends Area2D

signal installed

@export var component_type: String = "Motherboard" 

var is_dragging: bool = false
var start_position: Vector2 = Vector2.ZERO
var is_installed: bool = false 

func _ready() -> void:
	start_position = global_position

# 1. LOCAL EVENT: Only fires when the mouse clicks ON this specific component
func _input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if is_installed: 
		return
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		# Only look for the PRESSED action here
		if event.pressed:
			is_dragging = true
			z_index = 10 # Bring to front while dragging

# 2. GLOBAL EVENT: Fires for all inputs across the entire screen
func _input(event: InputEvent) -> void:
	# If we are currently dragging this object, and the player releases the Left Mouse Button...
	if is_dragging and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if not event.pressed: # The button was released!
			is_dragging = false
			z_index = 0
			_check_drop_zone()

func _process(_delta: float) -> void:
	if is_dragging:
		# Smoothly follow the mouse cursor
		global_position = get_global_mouse_position()

func _check_drop_zone() -> void:
	var overlapping_areas: Array[Area2D] = get_overlapping_areas()
	
	for area in overlapping_areas:
		if area.name == "Motherboard_Tray": 
			global_position = area.global_position
			is_installed = true 
			is_dragging = false
			print("Motherboard successfully mounted in the case!")
			installed.emit() 
			return 
	
	# Snap back to the start if dropped in the wrong spot
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", start_position, 0.2).set_trans(Tween.TRANS_SINE)
