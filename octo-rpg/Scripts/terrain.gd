extends Node3D

@export var map_size_x: int = 10
@export var map_size_z: int = 10
@export var tile_size: float = 1.0
@export var color_blue: Color = Color(0.2, 0.4, 1.0)
@export var color_green: Color = Color(0.2, 1.0, 0.3)

func _ready():
	randomize()
	generate_tiles()

func generate_tiles():
	var offset_x = (map_size_x * tile_size) / 2.0
	var offset_z = (map_size_z * tile_size) / 2.0

	for x in range(map_size_x):
		for z in range(map_size_z):
			var tile = MeshInstance3D.new()
			
			# Define o plano
			var mesh = PlaneMesh.new()
			mesh.size = Vector2(tile_size, tile_size)
			tile.mesh = mesh
			
			# Centraliza o mapa
			tile.position = Vector3(
				x * tile_size - offset_x + tile_size / 2.0,
				0.01,
				z * tile_size - offset_z + tile_size / 2.0
			)
			
			# Cor aleatória
			var mat = StandardMaterial3D.new()
			mat.albedo_color = color_blue if randf() < 0.5 else color_green
			tile.material_override = mat
			
			add_child(tile)
