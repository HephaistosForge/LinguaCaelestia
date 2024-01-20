extends Marker2D

const INCOMING_MISSILE_WARNING_PREFAB = preload("res://player/ui/incoming_missile_warning.tscn")
const SHIELD_PREFAB = preload("res://entities/mothership/shield.tscn")

const SHIELD_OFFSET = 140
const OFFSET = 90

var impact_warnings = {}
var shield: Node2D


func spawn_shield(language: Language):
	if is_instance_valid(shield):
		shield.queue_free()
	shield = SHIELD_PREFAB.instantiate()
	shield.color = language.color
	shield.language = language
	self.add_child(shield)
	shield.position.y -= SHIELD_OFFSET


func add_incoming_missile(weapon: Node2D, language: Language, index: int):
	if impact_warnings.has(language.language) and is_instance_valid(impact_warnings[language.language]):
		impact_warnings[language.language].add_weapon(weapon)
	else:
		display_impact_warning(weapon, language, index)


func display_impact_warning(weapon: Node2D, language: Language, index: int):
	var warning = INCOMING_MISSILE_WARNING_PREFAB.instantiate()
	impact_warnings[language.language] = warning
	add_child(warning)
	warning.init(language, language.color, language.shield_words[index], weapon, self)
	refresh_warning_positions()
	warning.on_dismiss.connect(_on_impact_warning_dismissed)


func refresh_warning_positions():
	for index in len(impact_warnings.keys()):
		if not is_instance_valid(impact_warnings.values()[index]):
			continue
		impact_warnings.values()[index].global_position = self.global_position
		
		impact_warnings.values()[index].position.y -= (index + 1) * OFFSET


func _on_correctly_typed(correctly_typed):
	var language = correctly_typed.language
	if is_instance_valid(impact_warnings[language.language]):
		impact_warnings[language.language].dismiss_warning()
		impact_warnings.erase(language.language)
		spawn_shield(language)
	


func _on_impact_warning_dismissed(warning):
	if not is_instance_valid(self):
		return
	impact_warnings.erase(warning)
	refresh_warning_positions()

