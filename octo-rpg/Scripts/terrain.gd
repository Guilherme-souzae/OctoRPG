extends Node3D

@export var map_size_x: int = 30
@export var map_size_z: int = 30
@export var tile_size: float = 1.0
@export var noise_scale: float = 0.1

# cores baseadas no valor do Perlin noise
@export var color_water: Color = Color(0.1, 0.3, 0.8)
@export var color_grass: Color = Color(0.1, 0.6, 0.2)
@export var color_sand: Color = Color(0.9, 0.8, 0.4)
@export var color_mountain: Color = Color(0.5, 0.4, 0.3)

func _ready():
	randomize()
	generate_map()

func generate_map():
	# cria e configura o gerador de ruído
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale

	# centraliza o mapa
	var offset_x = (map_size_x * tile_size) / 2.0
	var offset_z = (map_size_z * tile_size) / 2.0

	# gera os tiles
	for x in range(map_size_x):
		for z in range(map_size_z):
			var tile = MeshInstance3D.new()

			var mesh = PlaneMesh.new()
			mesh.size = Vector2(tile_size, tile_size)
			tile.mesh = mesh

			# mantém o terreno plano
			tile.position = Vector3(
				x * tile_size - offset_x + tile_size / 2.0,
				0.01,
				z * tile_size - offset_z + tile_size / 2.0
			)

			# obtém valor de noise (entre -1 e 1)
			var n = noise.get_noise_2d(float(x), float(z))
			n = (n + 1.0) / 2.0  # normaliza para 0–1

			# define cor conforme o valor do noise
			var mat = StandardMaterial3D.new()
			if n < 0.3:
				mat.albedo_color = color_water
			elif n < 0.45:
				mat.albedo_color = color_sand
			elif n < 0.75:
				mat.albedo_color = color_grass
			else:
				mat.albedo_color = color_mountain

			tile.material_override = mat
			add_child(tile)
