extends Node2D

func _ready():
	$Particles.emitting = true
	

func set_dir(vector):
	$Particles.direction = vector
