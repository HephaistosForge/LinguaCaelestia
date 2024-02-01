extends Node2D

const ROCKET_SCENE = preload("res://entities/weapons/rocket/rocket.tscn")
const INGAME_MENU_PREFAB = preload("res://ui/ingame_menu/ingame_menu.tscn")

@export var rocket_stats: RocketStats = RocketStats.new()

@onready var input_manager: Node = $InputManager
@onready var score_manager: Node = $ScoreManager
@onready var difficulty_manager: Node = $DifficultyManager

var target_positions: Array[Vector2]
var target_occupants: Array


func _ready():
	for node in get_tree().get_nodes_in_group("enemy_target_position"):
		target_positions.append(node.global_position)
		target_occupants.append(null)
	_spawn_enemy()


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		var ingame_menu = INGAME_MENU_PREFAB.instantiate()
		get_tree().root.add_child(ingame_menu)
		ingame_menu.tree_exiting.connect(_on_ingame_menu_dismissed)


func _on_ingame_menu_dismissed():
	input_manager.grab_text_edit_focus()
		

func _on_enemy_spawn_timer():
	_spawn_enemy()


func _get_free_index():
	var unoccupied = []
	for i in range(0, len(target_positions)):
		if target_occupants[i] == null:
			unoccupied.append(i)
	if len(target_positions) - len(unoccupied) >= difficulty_manager.get_difficulty():
		return null
	if unoccupied.is_empty():
		return null
	return unoccupied.pick_random()


func _spawn_enemy(from_language=null):
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
	cruiser.connect("enemy_typed_label", _player_launch_rocket_at)
	cruiser.destroyed.connect(_on_ship_destroyed)

func _on_ship_destroyed(index):
	target_occupants[index] = null
	score_manager.add_score(1)


func _random_enemy(lang=null):
	if lang == null:
		lang = Lang.LANGUAGES.pick_random()
	var cruiser = lang.cruiser_scene.instantiate()
	cruiser.language = lang
	cruiser.set_text(lang.ship_words.pick_random().strip_edges().to_lower())
	return cruiser


func _player_launch_rocket_at(node):
	var rocket_launch_pos = get_tree().get_first_node_in_group("rocket_launch_position")
	if is_instance_valid(rocket_launch_pos):
		var rocket = ROCKET_SCENE.instantiate()
		rocket.init(rocket_stats, node, Lang.ENGLISH, false)
		add_child(rocket)
		rocket.global_position = rocket_launch_pos.global_position



