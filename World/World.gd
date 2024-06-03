extends Node3D

const Cell = preload("res://Cell/Cell.tscn")

@export var Map: PackedScene
@onready var worldEnvironment: = $WorldEnvironment

var cells = []
#var x : CameraAttributesPractical = $"./WorldEnvironment".camera_attributes

func _ready():
	var environment = get_tree().root.world_3d.fallback_environment
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color.BLACK
	environment.ambient_light_color = Color("432d6d")
	generate_map()

func generate_map():
	if not Map is PackedScene: return
	var map = Map.instantiate()
	var tileMap = map.get_tilemap()
	var used_tiles = tileMap.get_used_cells(0)
	map.free() # We don't need it now that we have the tile data
	for tile in used_tiles:
		var cell = Cell.instantiate()
		add_child(cell)
		cell.position = Vector3(tile.x*Globals.GRID_SIZE, 0, tile.y*Globals.GRID_SIZE)
		cells.append(cell)
	for cell in cells:
		cell.update_faces(used_tiles)
