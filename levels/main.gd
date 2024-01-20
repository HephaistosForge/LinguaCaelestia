extends Node2D

const GAME_OVER_DIALOG = preload("res://ui/game_over_dialog/game_over_dialog.tscn")

func _on_mothership_player_death() -> void:
	var game_over_dialog = GAME_OVER_DIALOG.instantiate()
	self.add_child(game_over_dialog)
	var score = $ScoreLabel.text
	game_over_dialog.set_score(score)
	
