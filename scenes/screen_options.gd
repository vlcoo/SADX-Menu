extends ScreenBase

@onready var panel_container: PanelContainer = $PanelContainer

@onready var dialog_voice: ButtonDialog = $CanvasLayer/DialogVoice
@onready var dialog_text: ButtonDialog = $CanvasLayer/DialogText
@onready var dialog_generic_two: ButtonDialog = $CanvasLayer/DialogGenericTwo
@onready var label_sonic: Label = $PanelContainer/VBoxContainer/GridContainer/TextureRect/Label
@onready var button_generic_l: FancyButton = $CanvasLayer/DialogGenericTwo/HBoxContainer/ButtonGenericL
@onready var button_generic_r: FancyButton = $CanvasLayer/DialogGenericTwo/HBoxContainer/ButtonGenericR


func _ready() -> void:
	super()
	if randf() > 0.75: label_sonic.text = ["SANIC!", "SONCI!", "TAILS?"].pick_random()


func _on_button_sound_test_pressed() -> void:
	pass


func _on_button_msg_settings_pressed() -> void:
	button_generic_l.find_and_set_label_text("Voice & Text")
	button_generic_r.find_and_set_label_text("Voice Only")
	store_remembered_focus()
	dialog_generic_two.focus_on_appear = dialog_generic_two.get_node("HBoxContainer").get_child(NowSaving.current_save_file.opt_controller_rumble)
	dialog_generic_two.appear()


func _on_button_language_pressed() -> void:
	store_remembered_focus()
	dialog_voice.focus_on_appear = dialog_voice.get_node("VBoxContainer/HBoxContainer").get_child(NowSaving.current_save_file.opt_controller_rumble)
	dialog_voice.appear()


func _on_button_sound_pressed() -> void:
	button_generic_l.find_and_set_label_text("Stereo")
	button_generic_r.find_and_set_label_text("Mono")
	store_remembered_focus()
	dialog_generic_two.focus_on_appear = dialog_generic_two.get_node("HBoxContainer").get_child(NowSaving.current_save_file.opt_controller_rumble)
	dialog_generic_two.appear()


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
	await dialog_text.finished_disappearing
	restore_remembered_focus()
	NowSaving.appear()


func _on_button_exit_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_main.tscn")


func _on_button_rumble_pressed() -> void:
	button_generic_l.find_and_set_label_text("On")
	button_generic_r.find_and_set_label_text("Off")
	store_remembered_focus()
	dialog_generic_two.focus_on_appear = dialog_generic_two.get_node("HBoxContainer").get_child(NowSaving.current_save_file.opt_controller_rumble)
	dialog_generic_two.appear()


func _on_button_generic_pressed() -> void:
	dialog_generic_two.disappear()
	await dialog_generic_two.finished_disappearing
	restore_remembered_focus()
	NowSaving.appear()
