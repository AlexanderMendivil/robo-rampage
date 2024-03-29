extends Area3D



func _on_body_entered(body:Node3D):

	print(body)
	if body.is_in_group('PLAYER') or body is Enemy:
		body.hitpoint = 0
