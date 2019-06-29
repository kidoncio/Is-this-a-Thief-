extends ColorRect

const TUTORIAL_SCENE_NAME: String = "Tutorial"

func _on_Area2D_body_entered(body):
	if !body.has_node(Global.SUITCASE_NODE):
		return
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	var scene: String = get_tree().get_current_scene().get_name()
	
	if scene == TUTORIAL_SCENE_NAME:
		Configuration.configuration.level = 1
		get_tree().change_scene(Global.LEVEL_SCENE % str(Configuration.configuration.level))
	else:
		Configuration.configuration.level += 1
		Configuration.update_configuration_file()
		
		var scene_path: String = Global.LEVEL_SCENE % str(Configuration.configuration.level)
		
		if File.new().file_exists(scene_path):
			get_tree().change_scene(scene_path)
		else:
			Configuration.configuration.level = 1
			Configuration.update_configuration_file()
			
			get_tree().change_scene(Global.VICTORY_SCENE)