extends Node

var Player: KinematicBody2D
var navigation: Navigation2D
var destinations: Node2D

# Groups
const NPC_GROUP: String = "NPC"
const INTERFACE_GROUP: String = "interface"

# Volume
var VOLUME_VISION_SFX: float = -20.0

# Methods
const DARK_VISION_MODE_METHOD: String = "dark_vision_mode"
const NIGHT_VISION_MODE_METHOD: String = "night_vision_mode"

# Assets Path - !important
const nightvision_on_sfx: String = "res://SFX/nightvision.wav"
const nightvision_off_sfx: String = "res://SFX/nightvision_off.wav"

# Images Path
const RED_LIGHT: String = "res://GFX/Interface/PNG/dotRed.png"
const BLUE_LIGHT: String = "res://GFX/Interface/PNG/dotBlue.png"
const GREEN_LIGHT: String = "res://GFX/Interface/PNG/dotGreen.png"

# SFXs
const LOCKED_DOOR_CORRECT: String = "res://SFX/threeTone1.ogg"
const LOCKED_DOOR_BUTTON_PRESSED: String = "res://SFX/twoTone1.ogg"