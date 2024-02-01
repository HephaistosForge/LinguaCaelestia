extends Node2D

const HEALTH_PACK_PREFAB = preload("res://entities/health_pack/health_pack.tscn")

@onready var score_manager = $"../ScoreManager"


func _ready() -> void:
	score_manager.score_changed.connect(_on_score_changed)

func _on_score_changed(_score):
	if _score % 7 == 0:
		spawn_health_pack()

func spawn_health_pack():
	var x = randi_range(-int((get_viewport_rect().size.x/2) + 100), int((get_viewport_rect().size.x/2) - 100))
	var health_pack = HEALTH_PACK_PREFAB.instantiate()
	add_child(health_pack)
	health_pack.global_position = Vector2(x, -(float(get_viewport_rect().size.y/2)) - 100)
