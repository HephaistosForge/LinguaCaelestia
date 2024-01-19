extends Node2D

var LANGUAGES: Array[Language] = [
	Language.new(
		"latin", 
		["viva", "estus", "caesar", "latinos"], 
		["shield"],
		preload("res://entities/enemies/latin/cruiser.tscn"),
	),
]
