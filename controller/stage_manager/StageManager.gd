class_name StageManager extends Node2D

const STAGE_ANNOUNCEMENT_PREFAB: PackedScene = preload("res://ui/stage_announcement/stage_announcement.tscn")

@onready var name_generator: Node = $NameGenerator

var current_stage: Stage


func create_stage(difficulty: int):
	var stage_type: Stage.STAGE_TYPE = Stage.STAGE_TYPE.SMALL_FIGHT
	var stage: int
	var level: int
	var stage_name: String = name_generator.get_random_planet_name()
	
	current_stage = Stage.new(
			stage_type,
			difficulty,
			stage,
			level,
			stage_name
		)

func process_stage():
	show_stage_announcement()


func show_stage_announcement():
	var stage_annoncement: Node = STAGE_ANNOUNCEMENT_PREFAB.instantiate()
	self.add_child(stage_annoncement)
	stage_annoncement.init(current_stage.stage, current_stage.level, current_stage.stage_name)
	stage_annoncement.tree_exited.connect(_on_stage_announcement_dismissed)


func _on_stage_announcement_dismissed():
	_start_stage()


func _start_stage():
	current_stage.start()
	

func _check_for_stage_win() -> bool:
	return false


	
