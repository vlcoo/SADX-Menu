extends Object
class_name FakeSaveFile

var character_name := "Sonic"
var character_color := Color("#0055ff")
var character_clear_percents := [1.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var location_from_name := ""
var location_completed_name := ""
var play_time_minutes := 0
var emblem_count := 0

var opt_message_settings = 0
var opt_language_voice = 0
var opt_language_text = 0
var opt_sound_output = 0
var opt_controller_rumble = 0

const POSSIBLE_CHARACTER_NAMES = ["Sonic", "Tails", "Knuckles", "Amy", "Big", "E-102 “γ”"]
const CHARACTER_COLOURS = ["#0055ff", "#ffcc00", "#ff1100", "#ff88bb", "#7733cc", "#888888"]	# should've been taken from the list of SelectedCharacters on the CharacterViz, but eh...
const POSSIBLE_LOCATION_FROMS = ["Station Square", "Mystic Ruins", "Egg Carrier"]
const POSSIBLE_LOCATION_COMPLETEDS = ["Hedgehog Hammer", "Windy Valley", "Casinopolis", "Icecap", "Sky Deck", "Speed Highway", "Twinkle Park", "Icecap", "Emerald Coast", "Hot Shelter", "Emerald Coast", "Windy Valley", "Casinopolis", "Icecap", "Twinkle Park", "Speed Highway", "Red Mountain", "Sky Deck", "Lost World", "Final Egg", "Twinkle Park", "Hot Shelter", "Final Egg", "Emerald Coast", "Windy Valley", "Red Mountain", "Hot Shelter", "Speed Highway", "Casinopolis", "Red Mountain", "Lost World", "Sky Deck"]


func _init(randomize: bool) -> void:
	if not randomize: return
	
	# chara percents
	var randi = randi_range(2, character_clear_percents.size() - 1)
	character_clear_percents = [1.0]	# sonic is always unlocked and at 100%.
	for i in range(POSSIBLE_CHARACTER_NAMES.size() - 1):
		character_clear_percents.append(0.0 if i >= randi else randf_range(0.1, 1.0))
	
	# character
	var randi_character = randi_range(0, randi)
	character_name = POSSIBLE_CHARACTER_NAMES[randi_character]
	character_color = CHARACTER_COLOURS[randi_character]
	
	# locations
	location_from_name = POSSIBLE_LOCATION_FROMS.pick_random()
	location_completed_name = POSSIBLE_LOCATION_COMPLETEDS.pick_random()
	
	# counters
	play_time_minutes = randi_range(0, 750)
	emblem_count = randi_range(0, 130)
	var completion_multiplier = character_clear_percents.reduce(func(a, b): return a + b)
	#play_time_minutes *= completion_multiplier * 2
	#emblem_count *= completion_multiplier * 2
