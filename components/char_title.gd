extends TextureRect
class_name SelectedCharacterTitle

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label
var character: SelectedCharacterController:
	set(value):
		label.text = value.short_name.to_upper()
		label.self_modulate = value.colour


func _ready() -> void:
	label.pivot_offset = label.size / 2
