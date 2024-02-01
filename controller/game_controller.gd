class_name GameController extends Node2D

enum GAME_MODE {
	ENDLESS,
	CAMPAIGN
}

const INGAME_MENU_PREFAB = preload("res://ui/ingame_menu/ingame_menu.tscn")

@export var mode: GAME_MODE
@onready var input_manager: Node = $InputManager
@onready var score_manager: Node = $ScoreManager
@onready var difficulty_manager: Node = $DifficultyManager
@onready var enemy_manager: Node = $EnemyManager
@onready var health_pack_manager: Node = $HealthPackManager
@onready var stage_manager: Node = $StageManager


func _ready():
	match mode:
		GAME_MODE.ENDLESS:
			enemy_manager.start_endless()
		GAME_MODE.CAMPAIGN:
			stage_manager.start_campaign()


func get_mode() -> GAME_MODE:
	return mode


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		var ingame_menu = INGAME_MENU_PREFAB.instantiate()
		get_tree().root.add_child(ingame_menu)
		ingame_menu.tree_exiting.connect(_on_ingame_menu_dismissed)


func _on_ingame_menu_dismissed():
	input_manager.grab_text_edit_focus()

