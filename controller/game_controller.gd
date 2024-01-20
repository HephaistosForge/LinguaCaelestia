extends Node2D

var rocket_scene = preload("res://entities/projectile/rocket/rocket.tscn")

var target_positions: Array[Vector2]
var target_occupants: Array
var score = 0
var difficulty = 1

var increase_difficulty_at_score = [2, 5, 10, 20, 30, 50]

func _ready():
	for node in get_tree().get_nodes_in_group("enemy_target_position"):
		target_positions.append(node.global_position)
		target_occupants.append(null)
	_spawn_enemy()
	$TextEdit.grab_focus()

func _random_choice(arr):
	return arr[randi() % len(arr)]

func _on_enemy_spawn_timer():
	_spawn_enemy()
	
func _get_free_index():
	var empty = []
	for i in range(0, len(target_positions)):
		if target_occupants[i] == null:
			empty.append(i)
	if len(target_positions) - len(empty) >= difficulty:
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
	cruiser.position = target_pos * Vector2(0, 300)
	cruiser.target_position = target_pos
	add_child(cruiser)
	cruiser.connect("enemy_typed_label", _player_launch_rocket_at)
	cruiser.destroyed.connect(_on_ship_destroyed)
	
func _on_ship_destroyed(index):
	target_occupants[index] = null
	score += 1
	print(difficulty, score)
	if score in increase_difficulty_at_score:
		
		difficulty += 1
	
func _random_enemy():
	var lang = _random_choice(Lang.LANGUAGES)
	var cruiser = lang.cruiser_scene.instantiate()
	cruiser.language = lang
	cruiser.set_text(_random_choice(lang.ship_words).strip_edges().to_lower())
	return cruiser
	

func _player_launch_rocket_at(node):
	var rocket_launch_pos = get_tree().get_first_node_in_group("rocket_launch_position")
	if is_instance_valid(rocket_launch_pos):
		var rocket = rocket_scene.instantiate()
		rocket.position = rocket_launch_pos.position
		rocket.seek = node
		add_child(rocket)

func _on_text_edit_text_changed():
	var text = $TextEdit.text
	for typed_label in get_tree().get_nodes_in_group("typed_label"):
		if typed_label.type_text(text):
			$TextEdit.text = ""
			break
