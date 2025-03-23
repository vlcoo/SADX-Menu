extends Control
class_name ScreenBase

const NEGATIVE = preload("res://sadx out/COMMON_BANK00/B00_00_03.wav")

@onready var audio_music: AudioStreamPlayer = $AudioMusic
@onready var audio_voice: AudioStreamPlayer = $AudioVoice
@export var focus_on_enter: Control
@export var bg: Control
@export_flags("Fade In", "Fade Out") var bg_fades
@export var scene_when_escaped: PackedScene
var remembered_focus: Control

signal finished_fading_in


func _ready() -> void:
	if focus_on_enter is FancyButton: focus_on_enter.focus_immediately = true
	if focus_on_enter != null: focus_on_enter.grab_focus()
	
	if bg != null and bg_fades & 1:
		#var bg_tween = create_tween()
		#bg.self_modulate = Color.GRAY
		#bg_tween.tween_property(bg, ^"color" if bg is ColorRect else ^"self_modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		var mod_tween = create_tween()
		modulate.a = 0.35
		mod_tween.tween_property(self, ^"modulate", Color.WHITE, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		await mod_tween.finished
		finished_fading_in.emit()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_cancel") and scene_when_escaped != null:
		on_quit_screen()
		NowSaving.play_everywhere(NEGATIVE)
		audio_music.stop()
		audio_voice.stop()
		await get_tree().create_timer(0.4).timeout
		fade_and_change_scene_to_file(scene_when_escaped.resource_path)


func on_quit_screen() -> void:
	pass


func store_remembered_focus() -> void:
	remembered_focus = get_viewport().gui_get_focus_owner()


func restore_remembered_focus() -> void:
	if remembered_focus == null: return
	
	if remembered_focus is FancyButton: remembered_focus.focus_immediately = true
	remembered_focus.grab_focus()
	remembered_focus = null


func fade_and_change_scene_to_file(path: String) -> void:
	ResourceLoader.load_threaded_request(path)
	z_index -= 4
	
	if bg != null and bg_fades & 2:
		var bg_mod = create_tween()
		bg_mod.tween_property(self, ^"modulate:a", 0.65, 0.1).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		#await bg_mod.finished
	
	check_and_load_requested(path)


func check_and_load_requested(path: String) -> void:
	while ResourceLoader.load_threaded_get_status(path) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
		await get_tree().create_timer(0.05).timeout
	
	if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
		var scene: PackedScene = ResourceLoader.load_threaded_get(path)
		var scene_node = scene.instantiate()
		get_tree().root.add_child(scene_node)
		await scene_node.finished_fading_in
		queue_free()
