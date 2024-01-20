extends Node

const background_music = [
	preload("res://audio/soundtrack.mp3")
	]

const missile_explode = [
	preload("res://audio/missile_explosion.wav")
]
const missile_launch = [
	preload("res://audio/missile_launch.wav")
]
const missile_lock = [
	preload("res://audio/missile_lock.wav")
]
const shield_hit = [
	preload("res://audio/shieldhit_1.wav"),
	preload("res://audio/shieldhit_2.wav")
]
const shield_background = [
	preload("res://audio/shield_background.mp3")
]
const ship_arrive = [
	preload("res://audio/ship_arrive.wav")
]

const button_hover = [
]

const button_click = [
]

var music_volume = 3
var sound_volume = 3

@onready var background_player = $BackgroundMusic


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_background_music_finished()
	set_music_volume(music_volume)

# SOUNDS



func play_missile_launch():
	create_sound_player(missile_launch.pick_random(), null, false, 0.05)


func play_missile_hit():
	create_sound_player(missile_explode.pick_random(), null, false, 0.05)


func play_missile_lock():
	create_sound_player(missile_lock.pick_random(), null, false, 0.05)


func play_shield_hit():
	create_sound_player(shield_hit.pick_random(), null, false, 0.05)

func play_ship_arrive():
	create_sound_player(ship_arrive.pick_random(), null, false, 0.05)

func play_button_hover():
	if not button_hover.is_empty():
		create_sound_player(button_hover.pick_random(), null, false, 0.2)
	
func play_button_click():
	if not button_click.is_empty():
		create_sound_player(button_click.pick_random(), null, false, 0.2)

# HELPER

func create_sound_player(sound, position, modify = true, volume_factor: float =1):
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
