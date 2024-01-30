extends RocketShip

func _on_timer_timeout():
	for i in range(3):
		self.weapon.initial_launch_speed = 50 * (3 - i)
		attack()
		await get_tree().create_timer(0.3).timeout

