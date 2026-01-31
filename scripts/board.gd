class_name Board extends Node3D

# Map Info
@export var size: Vector2i = Vector2i(3,3)
@export var start: Vector2i = Vector2i(0,0)
@export var grid_tile_size: Vector2 = Vector2.ONE

# Prefabs
@export var tile_prefab: PackedScene

# Tracked Data
var tiles: Array[Array]
var player_pos: Vector2i
var player_rotation: Quaternion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tiles.resize(size.y)
	for j in range(size.y):
		var row = []
		row.resize(size.x)
		tiles[j] = row
	for i in range(size.x):
		for j in range(size.y):
			var new_tile = BoardTileData.new()
			new_tile.position = Vector2i(i,j)
			new_tile.color_index = -1
			var new_tile_node = tile_prefab.instantiate()
			new_tile_node.name = "Tile (" + str(i) + "," + str(j) + ")"
			new_tile_node.position = Vector3(i*grid_tile_size.x, 0, j*grid_tile_size.y)
			new_tile.node = new_tile_node
			add_child(new_tile_node)
			tiles[j][i] = new_tile
	
	player_pos = start
	player_rotation = Quaternion.IDENTITY

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func try_move_player(direction: Vector2i) -> bool:
	# Checking if move is possible
	var new_player_pos = player_pos + direction
	if new_player_pos.x < 0 or new_player_pos.y < 0 or new_player_pos.x >= size.x or new_player_pos.y >= size.y:
		return false
	var new_tile = tiles[new_player_pos.y][new_player_pos.x]
	if !new_tile:
		return false
	# Perform movement
	player_pos = new_player_pos
	var move_rotation = Quaternion.from_euler(Vector3(-PI/2*direction.y, 0, -PI/2*direction.x))
	var new_rotation = move_rotation * player_rotation
	player_rotation = new_rotation
	print(player_pos)
	print(player_rotation.get_euler())
	print("Player Cube Up is now ", player_rotation * Vector3.UP)
	return true
