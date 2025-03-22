extends ScreenBase

@onready var character_viz: CharacterViz = $CharacterViz


func _on_circle_button_pressed() -> void:
	character_viz.characters[character_viz.current_index].set_anim_selected()


func _on_circle_button_2_pressed() -> void:
	character_viz.switch_character(-1)


func _on_button_pressed() -> void:
	character_viz.switch_character(-1)
