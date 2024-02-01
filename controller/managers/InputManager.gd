extends Node2D

@onready var difficulty_manager = $"../DifficultyManager"
@onready var health_pack_manager = $"../HealthPackManager"
@onready var enemy_spawner = get_parent()


func _ready():
	grab_text_edit_focus()

func _on_text_edit_text_changed():
	AudioManager.play_key_press()
	var text = $TextEdit.text
	if "\n" in text:
		$TextEdit.text = ""
		return
	for typed_label in get_tree().get_nodes_in_group("typed_label"):
		if typed_label.type_text(text):
			$TextEdit.text = ""
			AudioManager.play_typewriter_bell()
			break
	if _handle_if_cheat($TextEdit.text):
		$TextEdit.text = ""


func grab_text_edit_focus() -> void:
	if $TextEdit.is_inside_tree():
		$TextEdit.grab_focus()


func _handle_if_cheat(text) -> bool:
	var mothership = get_tree().get_first_node_in_group("mothership")
	match text:
		"#heal":
			mothership.heal(100)
			return true
		"#damage":
			mothership.reduce_hp(100)
			return true
		"#spawn":
			enemy_spawner.spawn_enemy()
			return true
		"#difficulty":
			difficulty_manager.add_difficulty(1)
			return true
		"#hard":
			difficulty_manager.add_difficulty(10)
			return true
		"#invincible":
			mothership.max_hp = 10000000
			mothership.hp = 10000000
			return true
		"#pack":
			health_pack_manager.spawn_health_pack()
			return true
		"#nations":
			for lang in Lang.LANGUAGES:
				enemy_spawner._spawn_enemy(lang)
				pass
			return true
		"#chaos":
			_handle_if_cheat("#hard")
			_handle_if_cheat("#nations")
			_handle_if_cheat("#nations")
			_handle_if_cheat("#invincible")
			return true
	for lang in Lang.LANGUAGES:
		if text == "#" + lang.language:
			enemy_spawner._spawn_enemy(lang)
			return true
	return false
