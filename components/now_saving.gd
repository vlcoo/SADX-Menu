extends CanvasLayer

@onready var bar: TextureProgressBar = $TextureProgressBar
@onready var timer: Timer = $Timer
@onready var sfx: AudioStreamPlayer = $AudioStreamPlayer

var current_file_id := 0
var current_save_file: FakeSaveFile
var already_in_game := false

signal finished_saving


func _ready() -> void:
	current_save_file = FakeSaveFile.new(true)
	visible = false


func get_save_file_or_empty() -> FakeSaveFile:
	return current_save_file if current_file_id == 1 else FakeSaveFile.new(false)


func appear() -> void:
	visible = true
	bar.value = 0
	while bar.value < bar.max_value:
		var rand_wait_time = min(randf() / (bar.value * 0.2 + 0.1), 1)
		var rand_value_increase = min(abs(rand_wait_time * 4), 3)
		if bar.value > 0.5:
			rand_wait_time *= 0.5
			rand_value_increase *= 0.5
		timer.start(rand_wait_time)
		bar.value += rand_value_increase
		await timer.timeout
	visible = false
	finished_saving.emit()


func play_everywhere(stream: AudioStream):
	sfx.stream = stream
	sfx.play()
