extends ScreenBase

const POSITIVE = preload("res://sadx out/COMMON_BANK00/B00_00_02.wav")
@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var can_start: bool:
	get:
		return animation_player.current_animation == "blink"


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "in": can_start = true
	pass


func _on_button_start_pressed() -> void:
	if not can_start: return
	
	audio_music.stop()
	NowSaving.play_everywhere(POSITIVE)
	await get_tree().create_timer(0.07).timeout
	animation_player.play(&"out")
	fade_and_change_scene_to_file("res://scenes/screen_memcard.tscn")
