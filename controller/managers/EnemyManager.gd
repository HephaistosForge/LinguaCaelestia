extends Node2D

var target_positions: Array[Vector2]
var target_occupants: Array

@onready var score_manager = $"../ScoreManager"
@onready var difficulty_manager = $"../DifficultyManager"
@onready var mothership: Node = get_tree().get_first_node_in_group("mothership")
@onready var spawn_timer = $EnemySpawnTimer
@onready var stage_manager = $"../StageManager"


func _ready():
	for node in get_tree().get_nodes_in_group("enemy_target_position"):
		target_positions.append(node.global_position)
		target_occupants.append(null)
	

func start_endless():
	_spawn_enemy()
	spawn_timer.start()


func _get_free_index():
	var unoccupied = []
	for i in range(0, len(target_positions)):
		if target_occupants[i] == null:
			unoccupied.append(i)
	if len(target_positions) - len(unoccupied) >= difficulty_manager.get_difficulty() and get_parent().get_mode() != GameController.GAME_MODE.CAMPAIGN:
		return null
	if unoccupied.is_empty():
		return null
	return unoccupied.pick_random()


func _spawn_enemy(from_language=null, subscriber=null):
	var empty_index = _get_free_index()
	if empty_index == null:
		return
	var target_pos = target_positions[empty_index]
	var cruiser = _random_enemy(from_language)
	target_occupants[empty_index] = cruiser
	cruiser.index = empty_index
	cruiser.position = target_pos * Vector2(0, 300)
	cruiser.target_position = target_pos
	add_child(cruiser)
	cruiser.enemy_typed_label.connect(mothership.launch_rocket_at_node)
	cruiser.destroyed.connect(_on_ship_destroyed)
	if subscriber:
		cruiser.destroyed.connect(subscriber.on_ship_destroyed)
	

func _random_enemy(lang=null):
	if lang == null:
		lang = Lang.LANGUAGES.pick_random()
	var cruiser = lang.cruiser_scene.instantiate()
	cruiser.language = lang
	cruiser.set_text(lang.ship_words.pick_random().strip_edges().to_lower())
	return cruiser
	
	
func reduce_wait_time_by(time: float) -> void:
	spawn_timer.wait_time -= time
	print_debug("Enemy Spawn Timer set to:", spawn_timer.wait_time)


func _on_ship_destroyed(index):
	target_occupants[index] = null
	score_manager.add_score(1)


func _on_enemy_spawn_timer_timeout() -> void:
	_spawn_enemy()
