extends FancyButton

const FS_FILE_SITA_B = preload("res://sadx out/AVA_FILESEL_E_HD/fs_file_sita_b.png")
const FS_FILE_SITA_Y = preload("res://sadx out/AVA_FILESEL_E_HD/fs_file_sita_y.png")

@onready var texture_sub_bg: TextureRect = $TextureSubBG


func _on_focus_filebutton_entered() -> void:
	texture_sub_bg.texture = FS_FILE_SITA_Y


func _on_focus_filebutton_exited() -> void:
	texture_sub_bg.texture = FS_FILE_SITA_B
