extends Node2D

var rocket_scene = preload("res://entities/projectile/rocket/rocket.tscn")
const HEALTH_PACK_PREFAB = preload("res://entities/health_pack/health_pack.tscn")

var target_positions: Array[Vector2]
var target_occupants: Array
var score = 0
var difficulty = 1


var score_label: Label
var increase_difficulty_at_score = [2, 9, 20, 40, 60, 90, 120, 150, 180, 200, 250, 300, 350, 400, 450, 500]


func _ready():
	for node in get_tree().get_nodes_in_group("enemy_target_position"):
		target_positions.append(node.global_position)
		target_occupants.append(null)
	_spawn_enemy()
	$TextEdit.grab_focus()
	score_label = get_tree().get_first_node_in_group("score_label")

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
	score_label.text = str(score * 100)
	if score in increase_difficulty_at_score:
		difficulty += 1
		if difficulty > 8:
			$EnemySpawnTimer.wait_time -= 0.3
	if score % 7 == 0:
		spawn_health_pack()

func _random_enemy():
	var lang = _random_choice(Lang.LANGUAGES)
	var cruiser = lang.cruiser_scene.instantiate()
	cruiser.language = lang
	cruiser.set_text(_random_choice(lang.ship_words).strip_edges().to_lower())
	return cruiser


func spawn_health_pack():
	var x = randi_range((-float(get_viewport_rect().size.x)/2) + 100, (float(get_viewport_rect().size.x/2)) - 100)
	var health_pack = HEALTH_PACK_PREFAB.instantiate()
	add_child(health_pack)
	health_pack.global_position = Vector2(x, -(float(get_viewport_rect().size.y/2)) - 100)
	


func _player_launch_rocket_at(node):
	var rocket_launch_pos = get_tree().get_first_node_in_group("rocket_launch_position")
	if is_instance_valid(rocket_launch_pos):
		var rocket = rocket_scene.instantiate()
		rocket.seek = node
		add_child(rocket)
		rocket.global_position = rocket_launch_pos.global_position

func _on_text_edit_text_changed():
	AudioManager.play_key_press()
	var text = $TextEdit.text
	if "\n" in text:
		$TextEdit.text = ""
		return
	for typed_label in get_tree().get_nodes_in_group("typed_label"):
		if typed_label.type_text(text):
			$TextEdit.text = ""
			AudioManager.play_typewriter_bell()
			break
