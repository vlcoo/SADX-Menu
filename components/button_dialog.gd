extends PanelContainer
class_name ButtonDialog

@export var focus_on_appear: Control
@export var apply_focus_delay := false
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal finished_appearing
signal finished_disappearing


func _ready() -> void:
	pivot_offset = size / 2


func appear() -> void:
	scale = Vector2.ZERO
	visible = true
	if focus_on_appear is FancyButton: focus_on_appear.focus_immediately = true
	if apply_focus_delay: get_tree().create_timer(0.1).timeout
	focus_on_appear.grab_focus()
	animation_player.play(&"in")
	await animation_player.animation_finished
	finished_appearing.emit()


func disappear() -> void:
	animation_player.play(&"out")
	await animation_player.animation_finished
	#finished_disappearing.emit()
	visible = false
