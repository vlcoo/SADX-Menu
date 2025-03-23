extends TextureRect
class_name SelectedCharacterTitle

@onready var texture_rect: TextureRect = $TextureRect
@onready var label_anchor: Control = $LabelAnchor
@onready var label: Label = $LabelAnchor/Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var disabled := false:
	set(value):
		disabled = value
		if disabled: label.modulate = Color(1.0, 1.0, 1.0, 0.65)

var character: SelectedCharacterController:
	set(value):
		character = value
		label.text = value.short_name.to_upper()
		label.self_modulate = value.colour
		label.pivot_offset = label.size / 2

var selected_level: int = -1:
	set(value):
		selected_level = value
		match value:
			-2:
				label.visible = false
				label_anchor.scale = Vector2.ONE
			-1:
				label.visible = true
				animation_player.play(&"RESET")
				var tween = create_tween()
				tween.tween_property(self, ^"self_modulate", Color.BLUE, 0.5)
			0:
				label.visible = true
				label_anchor.scale = Vector2.ONE
				if not disabled: animation_player.play(&"flash")
				self_modulate = Color.RED
			1:
				animation_player.stop()
				label.visible = true
				label.scale = Vector2(1.6, 1.6)

const LABEL_POS_OFFSET := Vector2(0, -27)


func _process(delta: float) -> void:
	label_anchor.pivot_offset = label_anchor.size / 2
	label_anchor.position = pivot_offset + LABEL_POS_OFFSET - label_anchor.pivot_offset
	label_anchor.position.x += (label_anchor.global_position.x + label_anchor.pivot_offset.x - 320) * 0.003 * label_anchor.size.x
