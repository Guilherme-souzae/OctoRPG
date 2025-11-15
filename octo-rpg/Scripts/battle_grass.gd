extends Area3D

@export var combat_change := 0.3

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):
		if (randf() < 0.1):
			print("iniciando combate")
