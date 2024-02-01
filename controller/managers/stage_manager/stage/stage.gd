class_name Stage extends Node

enum STAGE_TYPE {
	SMALL_FIGHT,
	LARGE_FIGHT,
	BOSS_FIGHT,
	TRADER,
	INTERACTIVE
}

var difficulty: int
var stage: int
var level: int
var stage_name: String

signal stage_completed

func init(_difficulty: int, _stage: int, _level: int, _stage_name: String):
	self.difficulty = _difficulty
	self.stage = _stage
	self.level = _level
	self.stage_name = _stage_name


func start():
	push_warning("Stage type not implemented yet.")


func check_for_win():
	push_warning("Stage win condition not implemented.")
