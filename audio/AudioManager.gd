extends Node

const background_music = [
	]

const alarm = []
const button_hover = [
]

const button_click = [
]

var music_volume = 1
var sound_volume = 1

@onready var background_player = $BackgroundMusic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_background_music_finished()
	set_music_volume(music_volume)

# SOUNDS

func play_button_hover():
	create_sound_player(button_hover.pick_random(), null, false)
	
func play_button_click():
	create_sound_player(button_click.pick_random(), null, false)

# HELPER

func create_sound_player(sound, position, modify = true, volume_factor=1):
	var player
	if position == null:
		player = AudioStreamPlayer.new()
	else:
		player = AudioStreamPlayer2D.new()
	get_tree().root.add_child(player)
	if position:
		player.global_position = position
	player.stream = sound
	player.volume_db = linear_to_db((float(sound_volume*volume_factor)/100.0)*2)
	player.play()
	if modify:
		player.pitch_scale = 1 + randf_range(-0.2, +0.2)
	player.finished.connect(_on_sound_finished.bind(player))
	

func set_sound_volume(percent:float):
	sound_volume = percent
	
	
func set_music_volume(percent:float):
	music_volume = percent
	background_player.volume_db = linear_to_db((float(music_volume)/100.0))


func _on_background_music_finished() -> void:
	background_player.stream = background_music.pick_random()
	background_player.play()

func _on_sound_finished(player) -> void:
	player.queue_free()
