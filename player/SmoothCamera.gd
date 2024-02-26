extends Camera3D
class_name PlayerCamera
@export var speed := 44.0


func _physics_process(delta):
	global_transform = global_transform.interpolate_with(
		get_parent().global_transform,
		clamp(speed * delta, 0.0,0.1)
	)

	global_position = get_parent().global_position
	