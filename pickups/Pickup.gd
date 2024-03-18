extends Area3D
@export var ammo_type: AmmoHandler.ammo_type
@export var ammo_amount: int = 10
@onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("glowing")

func _on_body_entered(body:Node3D):
	if body.is_in_group("PLAYER"):
		body.ammo_handler.add_ammo(ammo_type, ammo_amount)
		queue_free()


func _on_animation_player_animation_finished(_anim_name):
	animation_player.play("glowing")
