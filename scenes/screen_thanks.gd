extends ScreenBase

@onready var dialog_a: ButtonDialog = $DialogA
@onready var global_fader: ColorRect = $GlobalFader


func _on_timer_dialog_timeout() -> void:
	dialog_a.appear()


func _on_button_restart_pressed() -> void:
	dialog_a.disappear()
	var tween = create_tween()
	tween.tween_property(global_fader, ^"modulate", Color.BLACK, 1.2)
	await tween.finished
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	fade_and_change_scene_to_file("res://scenes/screen_premain.tscn")


func _on_button_exit_pressed() -> void:
	dialog_a.disappear()
	var tween = create_tween()
	tween.tween_property(global_fader, ^"modulate", Color.BLACK, 1.2)
	await tween.finished
	audio_music.stop()
	audio_voice.stop()
	await get_tree().create_timer(0.65).timeout
	get_tree().quit()
