extends Node3D

@export var map_size_x: int = 30
@export var map_size_z: int = 30
@export var noise_scale: float = 0.1
@export var bush_chance: float = 0.15 # chance de spawnar um arbusto em blocos de grama

# tiles do terreno
var tiles := {
	"grass" = preload("res://Scenes/Exploration/Tiles/grass_tile.tscn"),
	"water" = preload("res://Scenes/Exploration/Tiles/water_tile.tscn"),
	"hill" = preload("res://Scenes/Exploration/Tiles/hill_tile.tscn"),
	"mountain" = preload("res://Scenes/Exploration/Tiles/mountain_tile.tscn")
}

# props do terreno
var props := {
	"bush" = preload("res://Scenes/Exploration/Props/battle_grass.tscn")
}

func _ready():
	randomize()
	generate_map()

func generate_map():
	var noise = FastNoiseLite.new()
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = noise_scale

	var offset_x = (map_size_x) / 2.0
	var offset_z = (map_size_z) / 2.0

	for x in range(map_size_x):
		for z in range(map_size_z):

			var n = noise.get_noise_2d(float(x), float(z))
			n = (n + 1.0) / 2.0

			var tile: Node3D
			var is_grass := false

			if n < 0.45:
				tile = tiles["water"].instantiate()
			elif n < 0.65:
				tile = tiles["grass"].instantiate()
				is_grass = true
			elif n < 0.75:
				tile = tiles["hill"].instantiate()
			else:
				tile = tiles["mountain"].instantiate()

			tile.position = Vector3(
				x - offset_x + 1 / 2.0,
				0,
				z - offset_z + 1 / 2.0
			)

			add_child(tile)

			# --- ADICIONA ARBUSTO EM CIMA DE ALGUNS TILES DE GRAMA ---
			if is_grass and randf() < bush_chance:
				var bush = props["bush"].instantiate()
				bush.position = tile.position + Vector3(0, 1, 0) # 1 unidade acima do tile
				add_child(bush)
