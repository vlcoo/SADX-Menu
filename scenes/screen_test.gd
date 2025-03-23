extends ScreenBase

@onready var dialog_a: ButtonDialog = $DialogA


func _ready() -> void:
	dialog_a.appear()


func _on_something_pressed() -> void:
	audio_music.stop()
	audio_voice.stop()
	dialog_a.disappear()
	await dialog_a.finished_disappearing
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_memcard.tscn")
