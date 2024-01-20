extends CenterContainer

@onready var score_dialog_label = $PanelContainer/MarginContainer/VBoxContainer/Label
var format_string = "Game Over! \nYou reached {score} points!"

func set_score(score: String):
	score_dialog_label.text = format_string.format({"score": score})

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
