extends Ship


var target_index_override = randi()

func _on_timer_timeout():
	target_override = projectile_targets[target_index_override % len(projectile_targets)]
	launch_rockets()

func configure_rocket_parameters():
	self.rocket_size = 0.4
	self.rocket_accel = 25
	self.rocket_initial_speed = 20
	self.rocket_launch_speed = 10
	self.rocket_max_speed = 100
	self.rocket_rotation_speed = 1.2
	self.rocket_damage = 30
