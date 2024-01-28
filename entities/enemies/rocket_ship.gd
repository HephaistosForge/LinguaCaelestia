extends Ship

class_name RocketShip

@export var weapon: RocketStats

var target_override = null

func attack():
	var target = get_random_target_on_mothership()
	
	if target_override != null:
		target = target_override
		
	if target == null:
		return
		
	for child in get_children():
		if child.is_in_group("enemy_rocket_launch_position"):
			var rocket = rocket_scene.instantiate()
			rocket.init(weapon, target, language, true)
			add_sibling(rocket)
			rocket.global_position = child.global_position
			if is_instance_valid(mothership):
				mothership.display_impact_warning(target, rocket, language)
