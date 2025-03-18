extends ScreenBase

@onready var dialog_voice: ButtonDialog = $CanvasLayer/DialogVoice


func _on_button_sound_test_pressed() -> void:
	pass


func _on_button_msg_settings_pressed() -> void:
	pass # Replace with function body.


func _on_button_language_pressed() -> void:
	store_remembered_focus()
	dialog_voice.appear()


func _on_button_sound_pressed() -> void:
	pass # Replace with function body.


func _on_button_file_pressed() -> void:
	pass # Replace with function body.


func _on_button_tv_pressed() -> void:
	pass # Replace with function body.


func _on_button_voice_english_pressed() -> void:
	dialog_voice.disappear()
	#await dialog_voice.finished_disappearing
	restore_remembered_focus()


func _on_button_voice_japanese_pressed() -> void:
	dialog_voice.disappear()
	#await dialog_voice.finished_disappearing
	restore_remembered_focus()
