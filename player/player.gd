extends CharacterBody3D
class_name Player

const SPEED := 5.0
@export var jump_height: float = 1.0
@export var fall_multiplier: float = 2.0
@export var max_hitpoints: float = 100.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera_pivot = $CameraPivot
@onready var animation_player = $AnimationPlayer

var mouse_motion := Vector2.ZERO
var hitpoint:float = max_hitpoints:
	set(value):
		if value < hitpoint:
			animation_player.stop(false)
			animation_player.play("TakeDamage")
		hitpoint = value
		if hitpoint <= 0:
			get_tree().quit()
		
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	handle_camera_rotation()
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y -= gravity * delta
		else:
			velocity.y -= gravity * delta * fall_multiplier
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(jump_height * gravity * 2)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		mouse_motion = -event.relative * 0.001
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func handle_camera_rotation() -> void:
	rotate_y(mouse_motion.x)
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -90, 90)
	mouse_motion = Vector2.ZERO
