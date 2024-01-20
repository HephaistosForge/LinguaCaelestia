extends Ship



func _on_timer_timeout():
	for i in range(5):
		launch_rockets(0.5, 300)
		await get_tree().create_timer(0.3).timeout
