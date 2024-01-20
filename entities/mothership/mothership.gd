extends Area2D

var max_hp = 1000
var hp = 1000
signal death

func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()


func display_impact_warning(projectile_target: Node2D) -> void:
	if not projectile_target is Marker2D:
		return
	projectile_target.display_impact_warning()


func reduce_hp(val: int) -> void:
	self.hp -= val
	self.hp = clamp(self.hp, 0, max_hp)
	if self.hp == 0:
		self.handle_death()


func handle_death() -> void:
	emit_signal("death")
	self.queue_free()


func spawn_shield(position_index):
	pass
