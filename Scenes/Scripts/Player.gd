extends "res://Scenes/Scripts/Character.gd"

var motion: Vector2 = Vector2()

var night_vision: bool = false
var vision_change_on_cooldown: bool = false
var vision_mode = Global.DARK_VISION_MODE_METHOD

export var night_visions: int = 3 # How many night visions you start with
export var night_vision_duration: int = 10 # How long a night vision can last (in seconds)

var disguised: bool = false

export var disguises: int = 3 # How many disguises you start with
export var disguise_duration: int = 5 # How long a disguise can last (in seconds)
export var disguise_slowdown: float = 0.5

const DEFAULT_VELOCITY_MULTIPLIER: float = 1.0
var velocity_multiplier: float = 1

func _ready():
	Global.Player = self
	collision_layer = Global.PLAYER_LAYER
	$DisguiseTimer.wait_time = disguise_duration
	reveal()
	disguise_display_update()


func _process(delta):
	update_motion(delta)
	move_and_slide(motion * velocity_multiplier)
	disguise_label_update()


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
	elif disguises > 0:
		disguise()


func reveal() -> void:
	$DisguiseLabel.visible = false
	$Sprite.texture = load(Global.PLAYER_SPRITE)
	$Light2D.texture = load(Global.PLAYER_SPRITE)
	collision_layer = Global.PLAYER_LAYER
	velocity_multiplier = DEFAULT_VELOCITY_MULTIPLIER
	
	disguised = false


func disguise() -> void:
	$DisguiseLabel.visible = true
	$Sprite.texture = load(Global.SOLDIER_SPRITE)
	$Light2D.texture = load(Global.SOLDIER_SPRITE)
	collision_layer = Global.DISGUISE_LAYER
	
	velocity_multiplier = disguise_slowdown
	
	disguises -= 1
	disguise_display_update()
	
	disguised = true
	
	$DisguiseTimer.start()


func disguise_label_update() -> void:
	if !disguised:
		return
	
	$DisguiseLabel.rect_rotation = - rotation_degrees
	$DisguiseLabel.text = str($DisguiseTimer.time_left).pad_decimals(2)


func disguise_display_update() -> void:
	get_tree().call_group(Global.DISGUISE_DISPLAY_GROUP,  Global.UPDATE_DISGUISE_DISPLAY_METHOD, disguises)


func collect_suitcase() -> void:
	get_tree().call_group(Global.INTERFACE_GROUP, Global.COLLECT_LOOT_METHOD)
	
	var loot = Node.new()
	loot.set_name(Global.SUITCASE_NODE)
	add_child(loot)