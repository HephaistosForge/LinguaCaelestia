class_name SmallFightStage extends Stage

var enemies_to_spawn: int
var spawned_enemies: int = 0
var destroyed_enemies: int = 0
var active_enemies: int = 0

var spawn_wait_time: float

var available_nations: Array[Lang]

@onready var enemy_manager: Node = get_tree().get_first_node_in_group("game_controller").enemy_manager
@onready var timer: Timer = $Timer


func start():
	setup()
	_on_timer_timeout()
	timer.start(spawn_wait_time)


func setup():
	enemies_to_spawn = difficulty + (stage * level)
	spawn_wait_time = (level * 10.0) / difficulty 
	print_debug(stage, level, enemies_to_spawn, difficulty)


func check_for_win() -> bool:
	return destroyed_enemies >= enemies_to_spawn


func _on_timer_timeout() -> void:
	if spawned_enemies < enemies_to_spawn:
		enemy_manager._spawn_enemy(null, self)
		spawned_enemies += 1
		active_enemies += 1


func on_ship_destroyed(_index):
	destroyed_enemies += 1
	active_enemies -= 1
	if check_for_win():
		stage_completed.emit()
