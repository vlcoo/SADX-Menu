extends TextureRect

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var parent_control: FancyButton
@export var disable_animation := false


func _ready() -> void:
	if parent_control == null:
		var parent = get_parent()
		assert(parent is FancyButton, "No suitable parent could be found for Focus object!!")
		parent_control = parent
	
	pivot_offset = size / 2
	if disable_animation: process_mode = Node.PROCESS_MODE_DISABLED


func _on_visibility_changed() -> void:
	if not is_node_ready(): return
	
	if visible and not parent_control.focus_immediately:
		animation_player.play(&"enter")
