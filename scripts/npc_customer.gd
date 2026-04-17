extends Area2D

# 1. Update the signal to pass exactly what your UI needs!
signal fade_in_complete(intro_text: String, customer_name: String, issue_text: String, issue_id: String)

const FADE_IN_DURATION = 1.0

# 2. Add the specific data for Gelo
var my_intro: String = "Hello there! I'm Gelo. I'm trying to build my first PC but I have no idea what I'm doing."
var my_name: String = "Gelo"
var my_issue: String = "1. Assemble computer hardware\n2. Install OS\n3. Cable Management"
var my_id: String = "task_001_gelo" # This is the ID that gets clipped to the board!

func fade_in_and_signal() -> void:
	modulate = Color(1.0, 1.0, 1.0, 0.0)
	var tween: Tween = create_tween()
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), FADE_IN_DURATION)
	tween.finished.connect(_on_tween_finished)

func _on_tween_finished() -> void:
	print("NPC fade-in complete.")
	# 3. Emit all the data at once
	fade_in_complete.emit(my_intro, my_name, my_issue, my_id)
