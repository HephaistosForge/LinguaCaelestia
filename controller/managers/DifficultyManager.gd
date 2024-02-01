extends Node2D

var difficulty = 1
var increase_difficulty_at_score = [2, 9, 20, 40, 60, 90, 120, 150, 180, 200, 250, 300, 350, 400, 450, 500]

@onready var score_manager = $"../ScoreManager"
@onready var enemy_manager = $"../EnemyManager"


func _ready():
	score_manager.score_changed.connect(_on_score_changed)


func get_difficulty() -> int:
	return difficulty
	

func set_difficulty(val: int) -> void:
	difficulty = val


func add_difficulty(val: int) -> void:
	set_difficulty(difficulty + val)


func _on_score_changed(_score):
	if _score in increase_difficulty_at_score:
		difficulty += 1
		if difficulty == 5 or difficulty == 7 or difficulty >= 9:
			enemy_manager.reduce_wait_time_by(0.3)
