extends Ship


var target_index_override = randi()

func _on_timer_timeout():
	target_override = projectile_targets[target_index_override % len(projectile_targets)]
	launch_rockets(0.4, 0, 50, 200, 30)

