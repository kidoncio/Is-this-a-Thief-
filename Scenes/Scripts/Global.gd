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

# Asset Links - !important
var nightvision_on_sfx: String = "res://SFX/nightvision.wav"
var nightvision_off_sfx: String = "res://SFX/nightvision_off.wav"