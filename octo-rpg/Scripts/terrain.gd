extends Node3D

@export var map_size_x: int = 30
@export var map_size_z: int = 30
@export var tile_size: float = 1.0
@export var noise_scale: float = 0.1

# tiles do terreno
var tiles := {
	"grass" = preload("res://Scenes/Exploration/Tiles/grass_tile.tscn"),
	"water" = preload("res://Scenes/Exploration/Tiles/water_tile.tscn")
}

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

			# obtém valor de noise
			var n = noise.get_noise_2d(float(x), float(z))
			n = (n + 1.0) / 2.0

			# escolhe qual tile instanciar
			var tile: Node3D
			if n < 0.45:
				tile = tiles["water"].instantiate()
			else:
				tile = tiles["grass"].instantiate()

			# posiciona
			tile.position = Vector3(
				x * tile_size - offset_x + tile_size / 2.0,
				0,
				z * tile_size - offset_z + tile_size / 2.0
			)

			# adiciona
			add_child(tile)
