extends Popup

# Signals
const PRESSED_SIGNAL: String = "pressed"

# Methods
const ON_BUTTON_PRESSED_METHOD: String = "_on_Button_pressed"

# Signals
const COMBINATION_CORRECT_SIGNAL: String = "combination_correct"

onready var _display = $VSplitContainer/VBoxContainer/DisplayContainer/Display
onready var _light = $VSplitContainer/VBoxContainer/ButtonContainer/ButtonGrid/Light

signal combination_correct

var combination = []
var guess = []

func _ready():
	connect_buttons()
	reset_lock(false)


func connect_buttons() -> void:
	for button in $VSplitContainer/VBoxContainer/ButtonContainer/ButtonGrid.get_children():
		if button is Button:
			button.connect(PRESSED_SIGNAL, self, ON_BUTTON_PRESSED_METHOD, [button.text])


func _on_Button_pressed(button: String) -> void:
	if button == "Ok":
		check_guess()
	else:
		enter(int(button))


func enter(button_number: int) -> void:
	$AudioStreamPlayer.stream = load(Global.LOCKED_DOOR_BUTTON_PRESSED)
	$AudioStreamPlayer.play()
	
	guess.append(button_number)
	update_display()


func check_guess() -> void:
	if guess.size() == 0:
		return
	
	if guess == combination:
		correct_combination()
	else:
		reset_lock()


func reset_lock(change_lights: bool = true) -> void:
	_display.clear()
	guess.clear()
	update_display()
	
	if !change_lights:
		return
	
	if is_visible():
		_light.texture = load(Global.RED_LIGHT)
		yield(get_tree().create_timer(0.5), "timeout")
		_light.texture = load(Global.BLUE_LIGHT)
	else:
		_light.texture = load(Global.BLUE_LIGHT)


func update_display() -> void:
	if guess.size() <= combination.size():
		_display.bbcode_text = "[center]" + PoolStringArray(guess).join("") + "[/center]"
	
	if guess.size() == combination.size():
		check_guess()


func correct_combination() -> void:
	$AudioStreamPlayer.stream = load(Global.LOCKED_DOOR_CORRECT)
	$AudioStreamPlayer.play()
	
	_light.texture = load(Global.GREEN_LIGHT)
	$Timer.start()


func _on_Timer_timeout():
	emit_signal(COMBINATION_CORRECT_SIGNAL)
	hide()
	reset_lock()
