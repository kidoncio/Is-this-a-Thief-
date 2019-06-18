extends "res://Scenes/Scripts/Character.gd"

const FIELD_OF_VIEW_TOLERANCE: float = 0.349066 # in radius
const MAX_DETECTION_RANGE: int = 320
const COLOR_RED: Color = Color(1, 0.25, 0.25)
const COLOR_WHITE: Color = Color(1, 1, 1)

onready var Player = get_node("/root/Level1/Player") # Make this level neutral

func _process(delta):
	$Torch.color = COLOR_WHITE
	
	if Player_is_in_FOV_TOLERANCE() && Player_is_in_LOS():
		$Torch.color = COLOR_RED


func Player_is_in_FOV_TOLERANCE() -> bool:
	var NPC_facing_direction = Vector2(1,0).rotated(global_rotation)
	var direction_to_Player = (Player.position - global_position).normalized()

	if abs(direction_to_Player.angle_to(NPC_facing_direction)) < FIELD_OF_VIEW_TOLERANCE:
		return true
	
	return false


func Player_is_in_LOS() -> bool:
	if !Player_is_in_range():
		return false
	
	var space: Physics2DDirectSpaceState = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	if !LOS_obstacle:
		return false
	
	if LOS_obstacle.collider == Player:
		return true
	
	return false


func Player_is_in_range() -> bool:
	var distance_to_player = Player.global_position.distance_to(global_position)
	return distance_to_player < MAX_DETECTION_RANGE