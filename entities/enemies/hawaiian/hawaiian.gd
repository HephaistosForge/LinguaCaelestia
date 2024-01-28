extends RocketShip

func _ready():
	super()
	target_override = get_random_target_on_mothership()

func _on_timer_timeout():
	attack()
