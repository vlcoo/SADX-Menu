extends ScreenBase

@onready var dialog_file: ButtonDialog = $CanvasLayer/DialogFile
@onready var dialog_delete: ButtonDialog = $CanvasLayer/DialogDelete
@onready var label_file_question: Label = $CanvasLayer/DialogDelete/VBoxContainer/LabelFileQuestion
@onready var container_file_buttons: VBoxContainer = $HBoxContainer/ContainerFileButtons

@onready var label_character_name: Label = $HBoxContainer/PanelContainer/VBoxContainer/TextureRect/LabelCharacterName
@onready var container_character_buttons: HBoxContainer = $HBoxContainer/PanelContainer/VBoxContainer/ContainerCharacterButtons
@onready var label_location_from: Label = $HBoxContainer/PanelContainer/VBoxContainer/TextureRect6/LabelLocationFrom
@onready var label_location_completed: Label = $HBoxContainer/PanelContainer/VBoxContainer/TextureRect7/LabelLocationCompleted
@onready var label_play_time: Label = $HBoxContainer/PanelContainer/VBoxContainer/TextureRect8/LabelPlayTime
@onready var label_emblem_count: Label = $HBoxContainer/PanelContainer/VBoxContainer/TextureRect9/HBoxContainer/LabelEmblemCount


var currently_selected_file := 0
var empty_save_file: FakeSaveFile


func _ready() -> void:
	if NowSaving.current_file_id > 0:
		var current_file_button = container_file_buttons.get_child(NowSaving.current_file_id - 1)
		focus_on_enter = current_file_button
	empty_save_file = FakeSaveFile.new(false)
	super()


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
	fade_and_change_scene_to_file("res://scenes/screen_options.tscn" if NowSaving.already_in_game else "res://scenes/screen_main.tscn")


func _on_button_file_cancel_pressed() -> void:
	dialog_file.disappear()
	await dialog_file.finished_disappearing
	restore_remembered_focus()


func _on_button_file_delete_pressed() -> void:
	dialog_file.disappear()
	await dialog_file.finished_disappearing
	label_file_question.text = "Delete file" + str(currently_selected_file) + "?"
	dialog_delete.appear()


func _on_button_delete_ok_pressed() -> void:
	dialog_delete.disappear()
	await dialog_delete.finished_disappearing
	restore_remembered_focus()
	NowSaving.appear()
	if currently_selected_file == 1:
		NowSaving.current_save_file = empty_save_file
		set_save_panel_info(NowSaving.current_save_file)


func _on_button_delete_cancel_pressed() -> void:
	dialog_delete.disappear()
	await dialog_delete.finished_disappearing
	restore_remembered_focus()


func _on_file_button_focus_entered(file_id: int) -> void:
	if file_id == 1:
		set_save_panel_info(NowSaving.current_save_file)
	else:
		set_save_panel_info(empty_save_file)


func set_save_panel_info(save_file: FakeSaveFile) -> void:
	label_character_name.text = save_file.character_name.to_upper()
	label_character_name.modulate = save_file.character_color
	var i = 0
	for percent in save_file.character_clear_percents:
		var button: TextureButton = container_character_buttons.get_child(i)
		button.disabled = percent == 0.0
		i += 1
	label_location_from.text = save_file.location_from_name
	label_location_completed.text = save_file.location_completed_name
	var hours = int(save_file.play_time_minutes / 60)
	var minutes = save_file.play_time_minutes - (hours * 60)
	minutes = int(minutes / 10) * 10
	label_play_time.text = str(hours) + ":" + str(minutes).pad_zeros(2)
	label_emblem_count.text = "x " + str(save_file.emblem_count)
	
