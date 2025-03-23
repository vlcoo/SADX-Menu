extends ScreenBase

@onready var character_viz: CharacterViz = $CharacterViz
@onready var label_file_id: Label = $Footer/TextureRect5/LabelFileId
@onready var container_full_name: PanelContainer = $Footer/ContainerFullName
@onready var label_full_name: Label = $Footer/ContainerFullName/VBoxContainer/LabelFullName
@onready var label_clear_percent: Label = $Footer/TextureRect6/LabelClearPercent
@onready var dialog_character_selected: ButtonDialog = $DialogCharacterSelected


func _ready() -> void:
	super()
	label_file_id.text = str(NowSaving.current_file_id)


func _on_circle_button_pressed() -> void:
	character_viz.characters[character_viz.current_index].set_anim_selected()


func _on_character_viz_character_changed(new_id: int) -> void:
	#if new_id < 0: return
	
	var character := character_viz.characters[new_id]
	var character_title := character_viz.character_titles[new_id]
	label_full_name.text = character.full_name.to_upper()
	var character_percent = NowSaving.get_save_file_or_empty().character_clear_percents[new_id]
	character_percent *= 10
	character_percent = int(floor(character_percent))
	character_percent *= 10
	label_clear_percent.text = str(character_percent) + "%"
	container_full_name.modulate = Color("#bcbcbc8e") if character_title.disabled else Color.WHITE


func _on_character_viz_character_selected() -> void:
	store_remembered_focus()
	if not character_viz.locked: dialog_character_selected.appear()


func _on_button_game_pressed() -> void:
	dialog_character_selected.disappear()
	await dialog_character_selected.finished_disappearing
	var voice_stream = character_viz.select_character()
	if voice_stream != null: audio_voice.stream = voice_stream
	audio_voice.play()
	await get_tree().create_timer(4).timeout
	fade_and_change_scene_to_file("res://scenes/screen_thanks.tscn")


func _on_button_instruction_pressed() -> void:
	pass # Replace with function body.


func _on_button_cancel_pressed() -> void:
	dialog_character_selected.disappear()
	await dialog_character_selected.finished_disappearing
	restore_remembered_focus()
	character_viz.locked = false
