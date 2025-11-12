extends Node

var characters = {}

func add_character(new_character: Character):
	characters[new_character.name] = new_character
