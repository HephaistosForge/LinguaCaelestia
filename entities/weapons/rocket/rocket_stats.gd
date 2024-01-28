extends WeaponStats

class_name RocketStats

@export var size := 1.0
@export var rotation_speed := 3.0
@export var max_speed := 400.0
@export var accel := 200.0
@export var damage := 100.0
@export var initial_speed := 0.0
# This is a speed which steadily deacreases after launch and may be larger than
# max speed. It is supposed to enumlate those rockets which are launched 
# first, and then start thrusting
@export var initial_launch_speed := 0.0
@export var initial_launch_speed_decay_seconds := 1.0
