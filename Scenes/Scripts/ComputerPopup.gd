extends Popup

func set_text(combination: Array) -> void:
	var text: String = "I can not believe you lost your password again!\n\nI've set it to " + PoolStringArray(combination).join("") + ", but this is the last time I do this."
	
	$RichTextLabel.bbcode_text = "[center][b]" + text + "[/b][/center]"