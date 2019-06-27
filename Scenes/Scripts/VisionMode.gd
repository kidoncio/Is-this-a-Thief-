extends CanvasModulate

# Colors
const DARK: Color = Color("0f1d53") # or 03081c to be more dark
const NIGHT_VISION: Color = Color("2bc92b")

func _ready():
	add_to_group(Global.INTERFACE_GROUP)
	color = DARK
	get_tree().call_group(Global.LABELS_GROUP, "hide")


func night_vision_mode() -> void:
	color = NIGHT_VISION
	inform_npcs(Global.NIGHT_VISION_MODE_METHOD)	
	play_sfx(Global.nightvision_on_sfx)
	get_tree().call_group(Global.LABELS_GROUP, "show")


func dark_vision_mode() -> void:
	color = DARK
	inform_npcs(Global.DARK_VISION_MODE_METHOD)
	play_sfx(Global.nightvision_off_sfx)
	get_tree().call_group(Global.LABELS_GROUP, "hide")


func play_sfx(asset_path: String) -> void:
	$AudioStreamPlayer.stream = load(asset_path)
	$AudioStreamPlayer.set_volume_db(Global.VOLUME_VISION_SFX) 
	$AudioStreamPlayer.play()


func inform_npcs(vision_mode: String) -> void:
	get_tree().call_group(Global.NPC_GROUP, vision_mode)