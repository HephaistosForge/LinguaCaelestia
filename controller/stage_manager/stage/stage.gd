class_name Stage extends Node

enum STAGE_TYPE {
	SMALL_FIGHT,
	LARGE_FIGHT,
	BOSS_FIGHT,
	TRADER,
	INTERACTIVE
}

var stage_type: STAGE_TYPE
var difficulty: int
var stage: int
var level: int
var stage_name: String


func _init(_stage_type: STAGE_TYPE, _difficulty: int, _stage: int, _level: int, _stage_name: String):
	self.stage_type = _stage_type
	self.difficulty = _difficulty
	self.stage = _stage
	self.level = _level
	self.stage_name = _stage_name


func start():
	push_warning("Stage type not implemented yet.")
