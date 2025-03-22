extends ScreenBase

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var audio_voice: AudioStreamPlayer = $AudioVoice
@onready var button_dialog: ButtonDialog = $ButtonDialog


func _ready() -> void:
	super()
	NowSaving.already_in_game = true


func _on_button_adventure_pressed() -> void:
	audio_voice.stop()
	button_dialog.disappear()
	await button_dialog.finished_disappearing
	audio_music.stop()
	await get_tree().create_timer(0.35).timeout
	fade_and_change_scene_to_file("res://scenes/screen_charselect.tscn")


func _on_button_trial_pressed() -> void:
	pass # Replace with function body.


func _on_button_options_pressed() -> void:
	audio_voice.stop()
	button_dialog.disappear()
	await button_dialog.finished_disappearing
	audio_music.stop()
	await get_tree().create_timer(0.35).timeout
	fade_and_change_scene_to_file("res://scenes/screen_options.tscn")


func _on_button_internet_pressed() -> void:
	pass # Replace with function body.
