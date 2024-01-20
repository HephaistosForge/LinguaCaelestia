extends Node2D

var rocket_scene = preload("res://entities/projectile/rocket/rocket.tscn")

var target_positions: Array[Vector2]
var target_occupants: Array
var score = 0

func _ready():
	for node in get_tree().get_nodes_in_group("enemy_target_position"):
		target_positions.append(node.global_position)
		target_occupants.append(null)
	_spawn_enemy()
	$TextEdit.grab_focus()

func _process(delta):
	pass

func _random_choice(arr):
	return arr[randi() % len(arr)]

func _on_enemy_spawn_timer():
	_spawn_enemy()
	
func _get_free_index():
	var empty = []
	for i in range(0, len(target_positions)):
		if target_occupants[i] == null:
			empty.append(i)
	if empty.is_empty():
		return null
	return _random_choice(empty)

func _spawn_enemy():
	var empty_index = _get_free_index()
	if empty_index == null:
		return
	var target_pos = target_positions[empty_index]
	var cruiser = _random_enemy()
	target_occupants[empty_index] = cruiser
	cruiser.index = empty_index
	cruiser.position = target_pos * Vector2(0, 500)
	cruiser.target_position = target_pos
	add_child(cruiser)
	cruiser.connect("enemy_typed_label", _player_launch_rocket_at)
	
func _on_ship_destroyed(index):
	target_occupants[index] = null
	score += 100
	
func _random_enemy():
	var lang = _random_choice(Lang.LANGUAGES)
	var cruiser = lang.cruiser_scene.instantiate()
	cruiser.set_text(_random_choice(lang.ship_words).strip_edges().to_lower())
	return cruiser
	

func _player_launch_rocket_at(node):
	var rocket = rocket_scene.instantiate()
	rocket.position = get_tree().get_first_node_in_group("rocket_launch_position").position
	rocket.seek = node
	add_child(rocket)

func _on_text_edit_text_changed():
	var text = $TextEdit.text
	for typed_label in get_tree().get_nodes_in_group("typed_label"):
		if typed_label.type_text(text):
			$TextEdit.text = ""
			break
