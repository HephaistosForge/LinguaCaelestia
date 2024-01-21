extends Ship


func _on_timer_timeout():
	for i in range(3):
		self.rocket_launch_speed = 50 * (3 - i)
		launch_rockets()
		await get_tree().create_timer(0.3).timeout

func configure_rocket_parameters():
	self.rocket_size = 0.5
	self.rocket_accel = 100
	self.rocket_initial_speed = 0
	self.rocket_launch_speed = 100
	self.rocket_max_speed = 50
	self.rocket_rotation_speed = 2
	self.rocket_launch_speed_decay_seconds = 1
	self.rocket_damage = 20
