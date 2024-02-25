extends Node3D

@onready var cooldown_timer:Timer = $CooldownTimer
@onready var weapon_position: Vector3 = weapon_mesh.position
@onready var ray_cast_3d:RayCast3D = $RayCast3D

@export var fire_rate: float = 14.0
@export var recoil: float = 0.05
@export var wepaon_damage: float = 0.0
@export var weapon_mesh: Node3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed('fire'):
		if cooldown_timer.is_stopped():
			shoot()

	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, (delta * 10.0))


func shoot() -> void:
	cooldown_timer.start(1.0 / fire_rate)
	weapon_mesh.position.z += recoil
	var collider: Object = ray_cast_3d.get_collider()
	if collider is Enemy:
		collider.hitpoint -= wepaon_damage