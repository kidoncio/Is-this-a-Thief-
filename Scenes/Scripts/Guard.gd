extends "res://Scenes/Scripts/PlayerDetection.gd"

var motion: Vector2 = Vector2()
var possible_destinations: Array = []
var path: Array = []
var destination: Vector2 = Vector2()

export var WALK_SLOWDOWN: float = 0.35
export var NAV_STOP_THRESHOLD: int = 5 # pixels

onready var navigation: Navigation2D = Global.navigation
onready var available_destinations: Node2D = Global.destinations

const MIN_WAIT_TIME: int = 4
const MAX_WAIT_TIME: int = 10

func _ready():
	possible_destinations = available_destinations.get_children()
	
	make_path()


func _process(delta):
	navigate()


func move() -> void:
	motion = (destination - position).normalized() * (MAX_SPEED * WALK_SLOWDOWN)
	
	if is_on_wall():
		yield(get_tree().create_timer(1.0), "timeout")
		
		if is_on_wall():
			make_path()
	
	look_at(destination)
	
	move_and_slide(motion)


func navigate() -> void:
	if Player_is_detected():
		yield(get_tree().create_timer(0.3), "timeout")
		
		if Player_is_detected():
			chase_the_Player()
			return
	
	var distance_to_destination: float = position.distance_to(path[0])
	destination = path[0]
	
	if distance_to_destination > NAV_STOP_THRESHOLD:
		move()
	else:
		update_path()


func make_path() -> void:
	randomize()
	var next_destination = possible_destinations[randi() % possible_destinations.size()]
	
	path = navigation.get_simple_path(global_position, next_destination.global_position, false)


func update_path() -> void:
	if path.size() == 1:
		if $Timer.is_stopped():
			var rng: RandomNumberGenerator = RandomNumberGenerator.new()
			rng.randomize()
			
			$Timer.wait_time = rng.randi_range(MIN_WAIT_TIME, MAX_WAIT_TIME)
			$Timer.start()
	else:
		path.remove(0)

func _on_Timer_timeout() -> void:
	make_path()


func chase_the_Player() -> void:
	motion = (Global.Player.position - position).normalized() * (MAX_SPEED * WALK_SLOWDOWN)
	
	look_at(Global.Player.position)
	
	move_and_slide(motion)