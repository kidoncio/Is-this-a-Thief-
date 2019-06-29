extends Node

var configuration: Dictionary = {
	"sound_muted": false,
	"level": 1
}


func _ready() -> void:
	configuration = get_configuration()
	update_sound()


func get_configuration():
	configuration = get_from_json(Global.CONFIGURATION_JSON)
	
	return configuration


func reset() -> void:
	configuration.sound_muted = false
	configuration.level = 1

	return


func get_from_json(filename: String):
	var file = File.new()
	file.open(filename, File.READ)
	
	var text: String = file.get_as_text()
	var data = parse_json(text)
	
	file.close()
	
	return data


func update_configuration_file(newConfiguration = null) -> void:
	if newConfiguration:
		configuration = newConfiguration
	
	var file = File.new()
	
	if file.open(Global.CONFIGURATION_JSON, File.WRITE) != 0:
		print("Error opening file")
		return

	file.store_line(to_json(configuration))
	file.close()
	
	return


func toggle_sound_muted() -> void:
	configuration.sound_muted = !configuration.sound_muted
	
	update_sound()


func update_sound() -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), configuration.sound_muted)
	Configuration.update_configuration_file()