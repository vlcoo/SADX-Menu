extends Control
class_name CharacterViz

const CHAR_TITLE = preload("res://components/char_title.tscn")
@onready var circle_center: Control = $CircleCenter

var characters: Array[SelectedCharacterController]
#var character_titles: Array[SelectedCharacterTitle]
var current_index := 0
var inbetween_angle = 0
var rotation_tween: Tween

const CIRCLE_RADIUS := 136


func _ready() -> void:
	for child in get_tree().get_nodes_in_group("SelectableCharacters"):
		assert(child is SelectedCharacterController, "Nodes in SelectableCharacters must be of correct object type!")
		child = child as SelectedCharacterController
		characters.append(child)
		var char_title = CHAR_TITLE.instantiate()
		circle_center.add_child(char_title)
		char_title.character = child
	distribute_titles_along_circle()


func switch_character(delta: int) -> void:
	if rotation_tween != null and rotation_tween.is_running(): return
	var new_index = current_index + delta
	var new_index_mod = new_index % characters.size()
	characters[current_index % characters.size()].visible = false
	characters[new_index_mod].set_anim_idle()
	characters[new_index_mod].visible = true
	rotation_tween = create_tween()
	rotation_tween.tween_method(distribute_titles_along_circle, inbetween_angle * current_index, inbetween_angle * new_index, 0.3)
	current_index = new_index


func distribute_titles_along_circle(angle_offset: float = 0) -> void:
	var i = 0
	inbetween_angle = (2 * PI) / characters.size()
	for child in circle_center.get_children():
		var angle = inbetween_angle * i + deg_to_rad(270) + angle_offset
		angle = -angle
		var pos = Vector2(cos(angle), sin(angle)) * CIRCLE_RADIUS - child.pivot_offset
		child.position = pos
		i += 1
