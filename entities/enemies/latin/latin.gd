extends Ship

func _on_timer_timeout():
	launch_rockets()

func configure_rocket_parameters():
	self.rocket_size = 0.8
	self.rocket_accel = 15
	self.rocket_initial_speed = 25
	self.rocket_launch_speed = 50
	self.rocket_max_speed = 50
	self.rocket_rotation_speed = 1
	self.rocket_damage = 50

