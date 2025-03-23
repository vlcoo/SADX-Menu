extends ScreenBase


func _on_vmu_button_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.5).timeout
	fade_and_change_scene_to_file("res://scenes/screen_file.tscn")


func _on_vmu_button_2_pressed() -> void:
	pass # Replace with function body.
