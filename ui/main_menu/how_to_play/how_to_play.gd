extends Control

const TUTORIAL_ITEM_PREFAB = preload("res://ui/main_menu/how_to_play/how_to_play_item.tscn")

var tutorial_items = [
	[
		preload("res://ui/main_menu/how_to_play/screenshots/enemies.png"), 
		"You're in enemy territory!", 
		"Multiple Nations have been seen out here in deep space."
	],	
	[
		preload("res://ui/main_menu/how_to_play/screenshots/activate.png"), 
		"Activate your ship's abilities", 
		"Type the corresponding codeword on your keyboard to activate your ships functions."
	],
	[
		preload("res://ui/main_menu/how_to_play/screenshots/defend.png"), 
		"Counter every attack", 
		"Our scientists have developed advanced shielding technology, which can nullify any enemy projectile. Type the correct codeword for your shieldgenerators in the language of the attacker to create a shield that destroys their projectiles."
	],
	[
		preload("res://ui/main_menu/how_to_play/screenshots/attack.png"), 
		"Attack your enemies!", 
		"Type the name of the enemy ships to send some missiles their way!"
	],
	[
		preload("res://ui/main_menu/how_to_play/screenshots/repair.png"), 
		"Repair your ship!", 
		"Space is full of debris of long forgotten battles. Collect some to restore your ship during long battles."
	]
	
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for item in tutorial_items:
		var tut_item = TUTORIAL_ITEM_PREFAB.instantiate()
		$MarginContainer/ScrollContainer/CenterContainer/GridContainer.add_child(tut_item)
		tut_item.init(item[0], item[1], item[2])
		
