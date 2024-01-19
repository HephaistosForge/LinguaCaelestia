extends Node

class_name Language

var language: String
var ship_words: Array
var shield_words: Array
var weapons: Array
var cruiser_scene: PackedScene

func _init(_language, _ship_words, _shield_words, _weapons, _cruiser_scene):
	language = _language
	ship_words = _ship_words
	shield_words = _shield_words
	weapons = _weapons
	cruiser_scene = _cruiser_scene
