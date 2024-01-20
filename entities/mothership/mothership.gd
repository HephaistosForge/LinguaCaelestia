extends Area2D

signal player_death

const INCOMING_MISSILE_WARNING_PREFAB = preload("res://player/ui/incoming_missile_warning.tscn")

var max_hp = 1000
var hp = 1000


func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D, weapon: Node2D, language: Language) -> void:
	if not projectile_target is Marker2D:
		return
	var warning = INCOMING_MISSILE_WARNING_PREFAB.instantiate()
	warning.set_input_text(language.shield_words.pick_random())
	self.add_child(warning)
	warning.global_position = projectile_target.global_position
	weapon.destroyed.connect(_on_weapon_destroyed)


func reduce_hp(val: int) -> void:
	self.hp -= val
	self.hp = clamp(self.hp, 0, max_hp)
	if self.hp == 0:
		self.handle_death()


func handle_death() -> void:
	player_death.emit()
	self.queue_free()


func spawn_shield(position_index):
	pass


func _on_weapon_destroyed(_weapon_ref):
	self.queue_free()
