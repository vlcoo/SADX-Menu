extends ScreenBase

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var audio_voice: AudioStreamPlayer = $AudioVoice
@onready var panel_container: PanelContainer = $PanelContainer

@onready var dialog_voice: ButtonDialog = $CanvasLayer/DialogVoice
@onready var dialog_text: ButtonDialog = $CanvasLayer/DialogText
@onready var label_sonic: Label = $PanelContainer/VBoxContainer/GridContainer/TextureRect/Label


func _ready() -> void:
	super()
	if randf() > 0.75: label_sonic.text = ["SANIC!", "SONCI!", "TAILS?"].pick_random()


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
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_memcard.tscn")


func _on_button_tv_pressed() -> void:
	pass # Replace with function body.


func _on_button_voice_pressed(language_chosen: String) -> void:
	dialog_voice.disappear()
	await dialog_voice.finished_disappearing
	dialog_text.appear()


func _on_button_text_pressed(language_chosen: String) -> void:
	dialog_text.disappear()
	restore_remembered_focus()
	await dialog_text.finished_disappearing
	NowSaving.appear()


func _on_button_exit_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.45).timeout
	get_tree().quit()
