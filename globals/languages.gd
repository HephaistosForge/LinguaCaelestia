extends Node2D

var ENGLISH: Language = Language.new(
	"english", 
	[
		"Fish sandwich","University","Semester","Holidays","Exam","Grades","Student","Lecturer",
		"Lecture theatre","Research","Campus","Library","Newspaper","Learning","Building",
		"Language","Philosophy","Computer","Paper","Pen","Dictionary","Formula","Number",
		"Alphabet","Lecture","Exercise","Mensa","Student ID","Timetable","Student Council",
		"Master thesis","Tuition fee","Regulations","Certificate","Scholarship","Excursion",
		"Student pub","Celebration","Campus party","Graduate","Internship","Security",
		"Mechanical engineering","Mathematics","After work hours","Computer Science","Zero",
		"One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"
	], 
	["Shield", "defend", "block", "protect", "Guard"],
	["Rocket","Laser"],
	Color.AQUAMARINE,
	preload("res://entities/enemies/latin/cruiser.tscn"),
)

var LANGUAGES: Array[Language] = [
	Language.new(
		"german", 
		[
			"Fischbrötchen","Universität","Semester","Ferien","Prüfung","Noten","Student","Dozent",
			"Hörsaal","Forschung","Campus","Bibliothek","Zeitung","lernen","Gebäude","Sprache",
			"Philosophie","Computer","Papier","Stift","Wörterbuch","Formel","Zahl","Alphabet",
			"Vorlesung","Übung","Kantine","Studentenausweis","Stundenplan","Fachschaft",
			"Masterarbeit","Studiengebühr","Ordnung","Zeugnis","Stipendium","Ausflug",
			"Studentenkneipe","Feier","Campusfest","Absolvent","Praktikum","Sicherheit",
			"Maschinenbau","Mathematik","Feierabend","Informatik","Null","Eins","Zwei","Drei",
			"Vier","Fünf","Sechs","Sieben","Acht","Neun","Zehn"
		], 
		["Schild", "verteidigen", "blocken", "schützen", "Wächter"],
		["Rakete","Laser"],
		Color.GOLDENROD,
		preload("res://entities/enemies/german/cruiser.tscn"),
	),
	Language.new(
		"latin", 
		[
			"Panis piscis","universitas","semestre","feriae","examinatio","iudicium","studens",
			"doctor","auditorium","indagatio","Campus","bibliotheca","diurna","discere",
			"aedificium","lingua","philosophia"," machina arithmetica","charta","clavulus",
			"index verborum","formula","numeru","litterarum ordo","schola","exercitatio","culina",
			"legitimatio studentis","tabula scholarum","studens consilium","opus diploma",
			"taxa studiorum","decretum","testimonium scholasticum","stipendium","excursio ",
			"popina studens","festum","festum scholasticum","examinandus","tirocinium",
			"securitas","fabricatio machinarum","mathematica","otium vespertinum",
			"disciplina informatica"," nullus ","unus ","duo ","tres ","quattuor ","quinque",
			"sex","septem ","octo","novem","decem"
		], 
		["scutum", "defensio", "arcēre", "tueri", "custodia"],
		["missile","telum"],
		Color.CRIMSON,
		preload("res://entities/enemies/latin/cruiser.tscn"),
	),
	Language.new(
		"hawaiian", 
		[
			"Berena i'a","kulanui","kau kau","Na la ho'omaha","Hoao","Loiloi","haumana kulanui","kumu",
			"hale ha'i'ōlelo","Ka noi'i","Kauhale Kulanui","Hale Puke","Nupepa","Ako","Hale","'Olelo",
			"No'ono'o ku'una","kamepiula","Pepa","Peni","puke wehewehe 'olelo","mana'o makemakika",
			"Helu","pi'apa","haiolelo","Kukakuka","Hale 'aina","Kaleka ID haumana","Papa manawa",
			"Aha Haumana","haku thesis","Na koina a'o","Kanawai","Palapala ho'ike","Kako'o ha'awina",
			"Huaka'i hele","Hale ku'ai haumana","Ho'olaule'a","Pa'ina pa kula","Ho'a'o 'ia",
			"hooikaika kino","Palekana","'enekinia 'enekinia","Makemakika","Ka pau ana o ka hana",
			"'epekema kamepiula","'ole","'ekahi","'elua","'ekolu","eha","'elima","'eono","'ehiku",
			"'ewalu","'eiwa","'umi"
		],
		["pale pale", "pale aku", "poloka", "e hoomalu", "kiai"],
		["pana", "ihe"],
		Color.LIME_GREEN,
		preload("res://entities/enemies/hawaiian/cruiser.tscn"),
	),
	Language.new(
		"french", 
		[
			"Sandwiches de poisson","Université","Semestre","Vacances","Examen","Notes","Étudiant",
			"Chargé de cours","amphithéâtre","Recherche","Campus","Bibliothèque","Journal",
			"apprendre","Bâtiment","Langue","Philosophie","Ordinateur","Papier","Stylo",
			"Dictionnaire","Formule","Nombre","Alphabet","Cours magistral","Exercice","Cantine",
			"Carte d'étudiant","Horaire","Département","Travail de master","Frais d'études",
			"Règlement","Certificat","Bourse d'études","Excursion","Bar des étudiants","Fête",
			"Fête du campus","Diplômé","Stage","Sécurité","Génie mécanique","Mathématiques",
			"Soirée de fête","Informatique","Zéro","Un","Deux","Trois","Quatre","Cinq","Six",
			"Sept","Huit","Neuf","Dix"
		], 
		["Bouclier", "défendent", "bloquer", "protègent", "Gardien"],
		["Missile","Laser"],
		Color.BLUE,
		preload("res://entities/enemies/french/cruiser.tscn"),
	),
]
