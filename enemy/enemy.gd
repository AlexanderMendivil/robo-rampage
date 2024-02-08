extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D

var player: CharacterBody3D
var provoked := false
var aggro_range := 12

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
	if direction:
		print("here")
		print(position)
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func look_at_target(director: Vector3) -> void:
	pass