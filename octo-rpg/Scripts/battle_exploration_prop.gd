extends StaticBody3D

@export var enemy_id = 0

func interact():
	print("Iniciando combate com monstro de ID: ", enemy_id)
	emit_signal("start battle", enemy_id)
