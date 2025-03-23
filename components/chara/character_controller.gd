extends Node3D
class_name SelectedCharacterController

@export var short_name: String
@export var full_name: String
@export var colour: Color
@export var anim: AnimationPlayer
@export var animation_idle: StringName
@export var animation_selected: StringName
@export var voice_stream: AudioStream


func _ready() -> void:
	set_anim_idle()
	anim.speed_scale = 1.25


func set_anim_idle() -> void:
	if animation_idle == "": return
	var full_animation_name = _find_animation_by_name(animation_idle)
	print("found " + full_animation_name + "!!")
	
	anim.get_animation(full_animation_name).loop_mode = Animation.LOOP_LINEAR
	anim.play(full_animation_name)


func set_anim_selected() -> AudioStream:
	if animation_selected == "": return
	anim.play(_find_animation_by_name(animation_selected))
	return voice_stream


func _find_animation_by_name(query: String) -> String:
	for anim_name in anim.get_animation_list():
		if query.to_lower() in anim_name.to_lower(): return anim_name
	return query
