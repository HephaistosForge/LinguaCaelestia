extends Node

const planet_names = [
"Phoebus", "Arcus", "Aurora", "Bacchus", "Bellona", "Caelus", "Ceres", "Concordia", "Cupid", "Cybele", "Diana", "Errata", "Faunus", "Febris", "Flora", "Fortuna", "Gentilis", "Halitus", "Ianus", "Iuno", "Iupiter", "Iuventus", "Katafractarium", "Luna", "Mars", "Mercurius", "Minerva", "Mutunus", "Nemesis", "Neptune", "Nyx", "Opullus", "Pluto", "Proserpina", "Pomona", "Quantum", "Raptor", "Saturn", "Senectus", "Somnus", "Spes", "Terra", "Trivia", "Umbra", "Venus", "Veritas", "Vesta", "Victoria", "Vis", "Vulcanus", "Xystus", "Yatus", "Zamia"
] 

const suffix_names = [
	"System", "Nebula", "Station", "Colony", "Outpost", "Base", "Patch", "Belt", "Pulsar System"
]

var alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"]

var planet_markov = {}

func _ready() -> void:
	load_names(planet_names, planet_markov)


func load_names(names, markov):
	for _name in names:
		var curr_name = _name
		for i in range(curr_name.length()):
			var curr_letter = curr_name[i].to_lower()
			var letter_to_add 
			if i == curr_name.length() - 1:
				letter_to_add = "."
			else:
				letter_to_add = curr_name[i+1]
			var tmp_list = []
			if markov.has(curr_letter):
				tmp_list = markov[curr_letter]
			tmp_list.append(letter_to_add)
			markov[curr_letter] = tmp_list


func get_markov_name(markov, min_length, max_length):
	var count = 1
	var markov_name = ""
	var random_letter = alphabet[randi_range(0, alphabet.size()-1)]
	markov_name += random_letter
	while count < max_length:
		var next_letter = get_next_letter(markov[markov_name.right(1)])
		if str(next_letter) == ".":
			if count > min_length:
				return markov_name.capitalize()
		else:
			markov_name += str(next_letter)
			count +=1
	return markov_name.capitalize()


func get_next_letter(markov):
	return markov[randi_range(0, markov.size()- 1)]


func get_random_planet_name():
	return get_markov_name(planet_markov, 5, 8) + suffix_names.pick_random()
