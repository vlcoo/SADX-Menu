extends Control
class_name ScreenBase

@export var focus_on_enter: Control
var remembered_focus: Control


func _ready() -> void:
	if focus_on_enter is FancyButton: focus_on_enter.focus_immediately = true
	focus_on_enter.grab_focus()


func store_remembered_focus() -> void:
	remembered_focus = get_viewport().gui_get_focus_owner()


func restore_remembered_focus() -> void:
	if remembered_focus == null: return
	
	if remembered_focus is FancyButton: remembered_focus.focus_immediately = true
	remembered_focus.grab_focus()
	remembered_focus = null
