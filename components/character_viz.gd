extends Control
class_name CharacterViz

const BEEP = preload("res://sadx out/COMMON_BANK00/B00_00_01.wav")
const POSITIVE = preload("res://sadx out/COMMON_BANK00/B00_00_02.wav")
const CHAR_TITLE = preload("res://components/char_title.tscn")

@onready var circle_center: Control = $CircleCenter
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer

var characters: Array[SelectedCharacterController]
var character_titles: Array[SelectedCharacterTitle]
var current_index := 0
var current_index_mod := 0
var inbetween_angle = 0
var rotation_tween: Tween
var locked := false:
	set(value):
		locked = value
		if value:
			pass
		else:
			for title in character_titles:
				if title.selected_level == -2:
					title.selected_level = -1
				elif title.selected_level == 1:
					title.selected_level = 0

const CIRCLE_RADIUS := 130

signal character_changed(new_id: int)
signal character_selected


func _ready() -> void:
	var i = 0
	for child in get_tree().get_nodes_in_group("SelectableCharacters"):
		assert(child is SelectedCharacterController, "Nodes in SelectableCharacters must be of correct object type!")
		child = child as SelectedCharacterController
		characters.append(child)
		var char_title = CHAR_TITLE.instantiate()
		circle_center.add_child(char_title)
		char_title.character = child
		char_title.disabled = NowSaving.get_save_file_or_empty().character_clear_percents[i] < 0.1
		character_titles.append(char_title)
		i += 1
	
	distribute_titles_along_circle()
	character_titles[0].selected_level = 0


func _unhandled_input(event: InputEvent) -> void:
	if locked or (rotation_tween != null and rotation_tween.is_running()): return
	
	if event.is_action_pressed(&"ui_right"):
		switch_character(1)
	
	elif event.is_action_pressed(&"ui_left"):
		switch_character(-1)
	
	elif event.is_action_pressed(&"ui_accept"):
		if character_titles[current_index_mod].disabled: return
		character_selected.emit()
		locked = true
		for title in character_titles:
			if title.selected_level == -1:
				title.selected_level = -2
			elif title.selected_level == 0:
				title.selected_level = 1


func switch_character(delta: int) -> void:
	sfx.stream = BEEP
	sfx.play()
	
	var new_index = current_index + delta
	var new_index_mod = new_index % characters.size()
	var old_index_mod = current_index % characters.size()
	var new_character := characters[new_index_mod]
	character_titles[old_index_mod].selected_level = -1
	
	rotation_tween = create_tween()
	rotation_tween.tween_method(distribute_titles_along_circle, inbetween_angle * current_index, inbetween_angle * new_index, 0.35).set_trans(Tween.TRANS_LINEAR)
	await rotation_tween.finished
	
	characters[old_index_mod].visible = false
	character_titles[new_index_mod].selected_level = 0
	new_character.set_anim_idle()
	new_character.visible = true
	current_index = new_index
	current_index_mod = new_index_mod
	
	character_changed.emit(new_index_mod)


func select_character() -> AudioStream:
	return characters[current_index_mod].set_anim_selected() 


func distribute_titles_along_circle(angle_offset: float = 0) -> void:
	var i = 0
	inbetween_angle = (2 * PI) / characters.size()
	
	for child in circle_center.get_children():
		var angle = inbetween_angle * i + deg_to_rad(270) - angle_offset
		angle = -angle
		var pos = Vector2(cos(angle), sin(angle)) * CIRCLE_RADIUS - child.pivot_offset
		child.position = pos
		i += 1
