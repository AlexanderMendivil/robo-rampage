extends Node3D

@onready var cooldown_timer:Timer = $CooldownTimer
@export var fire_rate := 14.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed('fire'):
		if cooldown_timer.is_stopped():
			cooldown_timer.start(1.0 / fire_rate)
			print("Pew!")
