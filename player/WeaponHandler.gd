extends Node3D


@export var weapon_1: Node3D 
@export var weapon_2: Node3D 

func _ready() -> void:
	equip(weapon_1)

func equip(active_weapon: Node3D) -> void:
	for child in get_children():
		if child == active_weapon:
			child.visible = true
			child.set_process(true)
			child.ammo_handler.update_ammo_label(child.ammo_type)
		else:
			child.visible = false
			child.set_process(false)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("weapon_1"):
		equip(weapon_1)
	if event.is_action_pressed("weapon_2"):
		equip(weapon_2)
	if event.is_action_pressed("next_weapon"):
		next_weapon()
	if event.is_action_pressed("last_weapon"):
		last_weapon()

func next_weapon() -> void:
	var index: int = get_current_index()
	index = wrapi(index+1, 0, get_child_count()) 
	equip(get_child(index))

func last_weapon() -> void:
	var index: int = get_children().size() - 1
	index = wrapi(index - 1, 0, get_child_count()) 
	equip(get_child(index))

func get_current_index() -> int:
	for i in get_child_count():
		if get_child(i).visible:
			return i
	return 0