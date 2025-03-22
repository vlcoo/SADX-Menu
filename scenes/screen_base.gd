extends Control
class_name ScreenBase

@export var focus_on_enter: Control
@export var bg: Control
@export_flags("Fade In", "Fade Out") var bg_fades
var remembered_focus: Control


func _ready() -> void:
	if focus_on_enter is FancyButton: focus_on_enter.focus_immediately = true
	if focus_on_enter != null: focus_on_enter.grab_focus()
	
	if bg != null and bg_fades & 1:
		var bg_tween = create_tween()
		bg.self_modulate = Color.GRAY
		bg_tween.tween_property(bg, ^"color" if bg is ColorRect else ^"self_modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)


func store_remembered_focus() -> void:
	remembered_focus = get_viewport().gui_get_focus_owner()


func restore_remembered_focus() -> void:
	if remembered_focus == null: return
	
	if remembered_focus is FancyButton: remembered_focus.focus_immediately = true
	remembered_focus.grab_focus()
	remembered_focus = null


func fade_and_change_scene_to_file(path: String) -> Error:
	if bg != null and bg_fades & 2:
		var bg_tween = create_tween()
		bg_tween.tween_property(bg, ^"color" if bg is ColorRect else ^"self_modulate", Color.GRAY, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		await bg_tween.finished
	return get_tree().change_scene_to_file(path)
