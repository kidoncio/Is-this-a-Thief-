extends "res://Scenes/Scripts/Character.gd"

var motion: Vector2 = Vector2()

var night_vision: bool = false
var vision_change_on_cooldown: bool = false
var vision_mode = Global.DARK_VISION_MODE_METHOD

var disguised: bool = false

func _ready():
	Global.Player = self
	collision_layer = 1

func _process(delta):
	update_motion(delta)
	move_and_slide(motion)


func update_motion(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.y = clamp((motion.y - SPEED), - MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.y = clamp((motion.y + SPEED), 0, MAX_SPEED)
	else:
		motion.y = lerp(motion.y, 0, FRICTION)
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = clamp((motion.x - SPEED), - MAX_SPEED, 0)
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = clamp((motion.x + SPEED), 0, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRICTION)


func _input(event) -> void:
	# Vision Mode Input
	if !vision_change_on_cooldown && Input.is_action_just_pressed("ui_select"):
		cycle_vision_mode()
		
	
	# Disguise Input
	if Input.is_action_just_pressed("toggle_disguise"):
		toggle_disguise()


func cycle_vision_mode():
	vision_change_on_cooldown = true
	
	if vision_mode == Global.DARK_VISION_MODE_METHOD:
		get_tree().call_group(Global.INTERFACE_GROUP, Global.NIGHT_VISION_MODE_METHOD)
		vision_mode = Global.NIGHT_VISION_MODE_METHOD
	elif vision_mode == Global.NIGHT_VISION_MODE_METHOD:
		get_tree().call_group(Global.INTERFACE_GROUP, Global.DARK_VISION_MODE_METHOD)
		vision_mode = Global.DARK_VISION_MODE_METHOD
	
	$VisionModeTimer.start()

func _on_VisionModeTimer_timeout():
	vision_change_on_cooldown = false


func toggle_disguise() -> void:
	if disguised:
		reveal()
	else:
		disguise()


func reveal() -> void:
	$Sprite.texture = load(Global.PLAYER_SPRITE)
	$Light2D.texture = load(Global.PLAYER_SPRITE)
	collision_layer = 1
	
	disguised = false


func disguise() -> void:
	$Sprite.texture = load(Global.SOLDIER_SPRITE)
	$Light2D.texture = load(Global.SOLDIER_SPRITE)
	collision_layer = 16
	
	disguised = true