extends Ship



func _on_timer_timeout():
	for i in range(3):
		launch_rockets(0.5, 0, 30, 100, 20)
		await get_tree().create_timer(0.3).timeout
