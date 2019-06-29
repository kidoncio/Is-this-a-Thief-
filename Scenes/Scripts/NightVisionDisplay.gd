extends ItemList

func update_night_vision_display(number: int) -> void:
	clear()
	for i in range(number):
		add_icon_item(load(Global.NIGHT_VISION_ICON), false)