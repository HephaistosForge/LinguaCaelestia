extends Area2D

signal player_death

var max_hp = 1000
var hp = 1000


func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D, weapon: Node2D, language: Language) -> void:
	if not projectile_target is Marker2D:
		return
	projectile_target.add_incoming_missile(weapon, language, projectile_target.get_index())


func reduce_hp(val: int) -> void:
	self.hp -= val
	self.hp = clamp(self.hp, 0, max_hp)
	if self.hp == 0:
		self.handle_death()


func heal(val: int) -> void:
	self.hp += val
	self.hp = clamp(self.hp, 0, max_hp)


func handle_death() -> void:
	player_death.emit()
	
	self.queue_free()



