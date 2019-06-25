extends NinePatchRect

func _ready():
	visible = false


func collect_loot():
	print("COLLECT LOOT")
	visible = true
	$LootList.add_icon_item(load(Global.SUITCASE_SPRITE_ICON), false)