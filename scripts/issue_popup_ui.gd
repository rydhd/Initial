extends CanvasLayer

# UPDATE THESE THREE LINES:
@onready var name_label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var description_text: RichTextLabel = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
@onready var clip_button: Button = $PanelContainer/MarginContainer/VBoxContainer/Button

# We store the issue ID so we know WHAT we are clipping to the board
var current_issue_id: String = ""

func _ready() -> void:
	# Now this will work because clip_button actually found the Button node!
	clip_button.pressed.connect(_on_clip_button_pressed)

# You call this function from your NPC script to populate the popup
func setup_issue(customer_name: String, issue_text: String, issue_id: String) -> void:
	name_label.text = "Customer: " + customer_name
	description_text.text = issue_text
	current_issue_id = issue_id

func _on_clip_button_pressed() -> void:
	# 1. Tell the rest of the game (and the Tutorial Manager!) that we clicked it
	EventBus.issue_clipped_to_board.emit(current_issue_id)
	
	# 2. Add an optional sound effect here
	# $PaperClipSound.play()
	
	# 3. Destroy this UI popup scene so the player can return to the game
	queue_free()
