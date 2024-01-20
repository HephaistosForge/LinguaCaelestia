extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles.emitting = true
	

func _on_particles_finished():
	queue_free()
