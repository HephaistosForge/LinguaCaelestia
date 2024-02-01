extends CanvasLayer

const OPTIONS_PREFAB = preload("res://ui/main_menu/options/options.tscn")
const TUTORIAL_PREFAB = preload("res://ui/main_menu/how_to_play/how_to_play.tscn")

@onready var dynamic_content_container = $Control/MarginContainer/VBoxContainer
var dynamic_content: Node = null


func _process(_delta:float) -> void:
	if Input.is_action_just_pressed("Pause"):
		_on_resume_button_pressed()


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	self.queue_free()


func _on_options_button_pressed() -> void:
	dismiss_dynamic_content_if_needed()
	var options = OPTIONS_PREFAB.instantiate()
	dynamic_content_container.add_child(options)
	dynamic_content = options


func _on_how_to_play_button_pressed() -> void:
	dismiss_dynamic_content_if_needed()
	var tutorial = TUTORIAL_PREFAB.instantiate()
	dynamic_content_container.add_child(tutorial)
	dynamic_content = tutorial


func dismiss_dynamic_content_if_needed() -> void:
	if dynamic_content:
		dynamic_content.queue_free()


func _on_start_new_game_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	self.queue_free()


func _on_back_to_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
	self.queue_free()



