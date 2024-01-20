extends Area2D

func get_projectile_targets() -> Array[Node]:
	return $ProjectileTargets.get_children()
