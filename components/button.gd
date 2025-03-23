extends TextureButton
class_name FancyButton

enum ConfirmType {SILENT, POSITIVE, NEGATIVE}

const BEEP = preload("res://sadx out/COMMON_BANK00/B00_00_01.wav")
const POSITIVE = preload("res://sadx out/COMMON_BANK00/B00_00_02.wav")
const NEGATIVE = preload("res://sadx out/COMMON_BANK00/B00_00_03.wav")

@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer
@onready var rectangle_focus: TextureRect = $Focus
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_bg: TextureRect = $TextureBG

@export var confirm_type := ConfirmType.POSITIVE
@export var grow_when_focused := false
@export var flash_when_focused := true
@export var label: Label
var focus_immediately := false


func _ready() -> void:
	pivot_offset = size / 2


func _process(delta: float) -> void:
	modulate.a = 0.65 if disabled else 1


func find_and_set_label_text(text: String) -> void:
	if label == null:
		for child in get_children():
			if child is Label: label = child
		for child in texture_bg.get_children():
			if child is Label: label = child
	
	if label != null: label.text = text


func _on_pressed() -> void:
	if confirm_type == ConfirmType.SILENT: return
	match confirm_type:
		ConfirmType.POSITIVE:
			sfx.stream = POSITIVE
		ConfirmType.NEGATIVE:
			sfx.stream = NEGATIVE
	sfx.play()


func _on_focus_entered() -> void:
	rectangle_focus.visible = true
	if not focus_immediately:
		sfx.stream = BEEP
		sfx.play()
	if flash_when_focused: animation_player.play(&"focus_flash")
	if grow_when_focused:
		texture_bg.scale = Vector2.ONE * 1.3
	
	focus_immediately = false


func _on_focus_exited() -> void:
	rectangle_focus.visible = false
	if flash_when_focused: animation_player.play(&"RESET")
	if grow_when_focused: texture_bg.scale = Vector2.ONE
