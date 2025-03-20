extends ScreenBase

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var audio_voice: AudioStreamPlayer = $AudioVoice
@onready var dialog_file: ButtonDialog = $CanvasLayer/DialogFile
@onready var dialog_delete: ButtonDialog = $CanvasLayer/DialogDelete
@onready var label_file_question: Label = $CanvasLayer/DialogDelete/VBoxContainer/LabelFileQuestion

var currently_selected_file := 0


func _on_file_button_cancel_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_memcard.tscn")


func _on_file_button_file_pressed(file_id: int) -> void:
	currently_selected_file = file_id
	store_remembered_focus()
	dialog_file.appear()


func _on_button_file_ok_pressed() -> void:
	NowSaving.current_file_id = currently_selected_file
	audio_voice.stop()
	dialog_file.disappear()
	await dialog_file.finished_disappearing
	audio_music.stop()
	await get_tree().create_timer(0.35).timeout
	fade_and_change_scene_to_file("res://scenes/screen_options.tscn")


func _on_button_file_cancel_pressed() -> void:
	dialog_file.disappear()
	restore_remembered_focus()


func _on_button_file_delete_pressed() -> void:
	dialog_file.disappear()
	await dialog_file.finished_disappearing
	label_file_question.text = "Delete file" + str(currently_selected_file) + "?"
	dialog_delete.appear()


func _on_button_delete_ok_pressed() -> void:
	dialog_delete.disappear()
	restore_remembered_focus()
	NowSaving.appear()


func _on_button_delete_cancel_pressed() -> void:
	dialog_delete.disappear()
	restore_remembered_focus()
