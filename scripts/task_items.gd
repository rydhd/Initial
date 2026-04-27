extends CanvasLayer

# Grab our Label using the unique name
@onready var task_1: Label = %Task1

func _ready() -> void:
	# Update the UI as soon as the scene loads
	_update_task_list()

func _update_task_list() -> void:
	# Ensure the Label actually exists to prevent null errors
	if not task_1:
		return
		
	# Check if the player finished the motherboard assembly
	if "Fix PC: Motherboard Assembly" in GlobalState.completed_tasks:
		
		# 1. Fade the label out to look "completed" (Grey with slight transparency)
		task_1.modulate = Color(0.5, 0.5, 0.5, 0.6) 
		
		# 2. Add a visual text indicator
		task_1.text = "1. Assemble motherboard [DONE]"
