class_name StageManager extends Node2D

const STAGE_ANNOUNCEMENT_PREFAB: PackedScene = preload("res://ui/stage_announcement/stage_announcement.tscn")

const SMALL_FIGHT_STAGE: PackedScene = preload("res://controller/managers/stage_manager/stage/small_fight_stage/SmallFightStage.tscn")


@onready var name_generator: Node = $NameGenerator


var current_stage: Stage


func start_campaign():
	current_stage = create_stage(Stage.STAGE_TYPE.SMALL_FIGHT, 2)
	add_child(current_stage)
	current_stage.stage_completed.connect(_on_stage_completed)
	process_stage()


func create_stage(stage_type: Stage.STAGE_TYPE, difficulty: int):
	var created_stage: Node
	var stage: int = 1
	var level: int = 1
	var stage_name: String = name_generator.get_random_planet_name()
	
	match stage_type:
		Stage.STAGE_TYPE.SMALL_FIGHT:
			created_stage = SMALL_FIGHT_STAGE.instantiate()
		Stage.STAGE_TYPE.LARGE_FIGHT:
			created_stage = SMALL_FIGHT_STAGE.instantiate()
		Stage.STAGE_TYPE.BOSS_FIGHT:
			created_stage = SMALL_FIGHT_STAGE.instantiate()
		Stage.STAGE_TYPE.TRADER:
			created_stage = SMALL_FIGHT_STAGE.instantiate()
		Stage.STAGE_TYPE.INTERACTIVE:
			created_stage = SMALL_FIGHT_STAGE.instantiate()
			
	created_stage.init(difficulty, stage, level, stage_name)
	return created_stage


func process_stage():
	show_stage_announcement()


func show_stage_announcement():
	var stage_annoncement: Node = STAGE_ANNOUNCEMENT_PREFAB.instantiate()
	self.add_child(stage_annoncement)
	stage_annoncement.init(current_stage.stage, current_stage.level, current_stage.stage_name)
	stage_annoncement.tree_exited.connect(_on_stage_announcement_dismissed)


func _on_stage_announcement_dismissed():
	current_stage.start()
	

func _on_stage_completed():
	current_stage.queue_free()
	#TODO: PROGRESSION
	start_campaign()


	
