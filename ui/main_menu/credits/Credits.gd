extends Control

const bold = preload("res://ui/fonts/NovaSquare-Regular.ttf")
const light = preload("res://ui/fonts/NovaSquare-Regular.ttf")
const regular = preload("res://ui/fonts/NovaSquare-Regular.ttf")


var music = ["Music", 
["Paradox by | e s c p | https://escp-music.bandcamp.com", "Music promoted by https://www.free-stock-music.com", "Creative Commons / Attribution 4.0 International (CC BY 4.0) https://creativecommons.org/licenses/by/4.0/"]
]

var shader = ["Shaders",
["Space Background Shader", "Star Nest by ColorauGuiyino\nhttps://godotshaders.com/shader/star-nest/", "MIT License"],
["Solar Flare Shader", "God Rays by pend00\nhttps://godotshaders.com/shader/god-rays/", "CC0 License"],
["Ship Shield Shader", "Radial plasma shield segment\nhttps://godotshaders.com/shader/radial-plasma-shield/", "CC0 License"]
]

var sound = ["Sound Design",
["Jonas Moesicke",null, null]
]

var art = ["Artists",
["Lukas Großehagenbrock",null, null],
]

var programing = ["Programmers",
["Jonas Moesicke",null, null],
["Brutenis Gliwa",null, null],
["Lukas Großehagenbrock",null, null]
]


var thanks = ["Thanks for Playing!"]

var licensing = ["",
	[
		"Deep In Space\n A game by Hephaistos' Forge","2024","MIT License"
	]
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_credits()


func create_credits():
	for section in [programing, art, sound, music, thanks, licensing]:
		var section_container = VBoxContainer.new()
		section_container.add_theme_constant_override("separation", 0)
		var section_header = Label.new()
		format_label(section_header, bold, 50)
		section_header.text = section.pop_front()
		
		self.add_child(section_header)
		for item in section:
			var item_container = VBoxContainer.new()
			item_container.add_theme_constant_override("separation", 2)
			
			var name_label = Label.new()
			var author = Label.new()
			var license = Label.new()
			
			name_label.text = item[0] if item[0] != null else ""
			author.text = item[1] if item[1] != null else ""
			license.text = "licensed under " + item[2] if item[2] != null else ""
			
			format_label(name_label, regular, 20)
			format_label(author, regular, 15)
			format_label(license, light, 10)
			
			item_container.add_child(name_label)
			item_container.add_child(author)
			item_container.add_child(license)
			section_container.add_child(item_container)
		self.add_child(section_container)


func format_label(label, font, font_size, alignment = HORIZONTAL_ALIGNMENT_CENTER):
	label.horizontal_alignment = alignment
	label.add_theme_font_override("font", font)
	label.add_theme_font_size_override("font_size", font_size)
