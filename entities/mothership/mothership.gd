extends Area2D

func get_projectile_targets() -> Array[Vector2]:
	var projectile_targets = []
	for child in $ProjectileTargets.get_children():
		projectile_targets.append(child.global_position)
	return projectile_targets
