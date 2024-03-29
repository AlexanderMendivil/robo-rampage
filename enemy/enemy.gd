extends CharacterBody3D
class_name Enemy 

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]

@export var attack_damage := 20
@export var attack_range := 1.5
@export var max_hitpoints: int = 100
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player: CharacterBody3D
var provoked := false
var aggro_range := 12

var hitpoint: int = max_hitpoints:
	set(value):
		hitpoint = value
		if hitpoint <= 0:
			queue_free()
		provoked = true


func _ready() -> void:
	player = get_tree().get_first_node_in_group("PLAYER")

func _process(_delta: float) -> void:
	if provoked:
		navigation_agent_3d.target_position = player.global_position

func _physics_process(delta):
	var next_position := navigation_agent_3d.get_next_path_position()
	if not is_on_floor():
		velocity.y -= gravity * delta

	var direction: Vector3 = global_position.direction_to(next_position)
	var distance: float  = global_position.distance_to(player.global_position)
	
	if distance <= aggro_range:
		provoked = true
	
	if provoked && distance <= attack_range:
		playback.travel("Attack")
		
	if direction:
		look_at_target(direction)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func look_at_target(direction: Vector3) -> void:
	var adjusted_director = direction
	adjusted_director.y = 0
	look_at(global_position + adjusted_director, Vector3.UP, true)


func attack() -> void:
	if player is Player:
		player.hitpoint -= attack_damage
