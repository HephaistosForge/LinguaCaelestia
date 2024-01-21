extends Ship


func _on_timer_timeout():
	launch_rockets()

func configure_rocket_parameters():
	self.rocket_size = 2
	self.rocket_accel = 25
	self.rocket_initial_speed = 0
	self.rocket_launch_speed = 200
	self.rocket_max_speed = 25
	self.rocket_rotation_speed = 0.6
	self.rocket_launch_speed_decay_seconds = 2
	self.rocket_damage = 400
