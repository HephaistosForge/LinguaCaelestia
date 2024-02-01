extends Node2D

var score: int = 0
var score_label: Label

signal score_changed

func _ready() -> void:
	score_label = get_tree().get_first_node_in_group("score_label")


func get_score():
	return score


func set_score(val: int):
	score = val
	score_changed.emit(score)
	update_score_label()
	

func add_score(val: int):
	set_score(score + val)


func update_score_label():
	score_label.text = str(score * 100)
