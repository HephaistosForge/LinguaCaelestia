extends Ship


func _on_timer_timeout():
	launch_rockets(2, 0, 25, 50, 400)
