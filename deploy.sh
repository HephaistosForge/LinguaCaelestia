rm ./builds/html/*
godot --export-release Web ./builds/html/index.html
scp ./builds/html/* vega:cybertrio
