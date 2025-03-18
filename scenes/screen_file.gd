extends ScreenBase

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var audio_voice: AudioStreamPlayer = $AudioVoice


func _on_file_button_cancel_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_memcard.tscn")


func _on_file_button_file_pressed(file_id: int) -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_options.tscn")
