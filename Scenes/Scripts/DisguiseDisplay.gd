extends ItemList

func update_disguises(number: int) -> void:
	clear()
	for i in range(number):
		add_icon_item(load(Global.DISGUISE_HELMET_ICON), false)