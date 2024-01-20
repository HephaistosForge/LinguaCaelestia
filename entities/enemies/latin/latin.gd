extends Ship

func _on_timer_timeout():
	launch_rockets(0.8, 0, 50, 200, 50)
