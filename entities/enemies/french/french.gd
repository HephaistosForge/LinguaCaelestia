extends Ship



func _on_timer_timeout():
	for i in range(3):
		launch_rockets(0.5, 0, 50, 200, 30)
		await get_tree().create_timer(0.1).timeout
