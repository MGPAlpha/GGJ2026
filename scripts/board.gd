class_name Board extends Node3D

# Map Info
@export var size: Vector2i = Vector2i(3,3)
@export var start: Vector2i = Vector2i(0,0)
@export var grid_tile_size: Vector2 = Vector2.ONE
@export var colors : Array[Color] = [Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE, Color.PURPLE]
@export var tile_height: float = .7

# Prefabs
@export var player_prefab: PackedScene
@export var tile_prefab: PackedScene

# Tracked Data
var tiles: Array[Array]
var player_pos: Vector2i
var player_rotation: Quaternion
var player_node: PlayerCube
@export var player_colors: Dictionary[Vector3i, int] = {
	Vector3i.UP: -1,
	Vector3i.DOWN: -1,
	Vector3i.LEFT: -1,
	Vector3i.RIGHT: -1,
	Vector3i.FORWARD: -1,
	Vector3i.BACK: -1
}

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
	var player_tile = tiles[player_pos.y][player_pos.x]
	var down_color = player_colors[Vector3i.DOWN]
	if down_color > -1:
		paint_tile(player_tile, down_color)
	player_node = player_prefab.instantiate()
	player_node.position = get_player_pos_for_tile(player_tile)
	add_child(player_node)

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
	var move_rotation = Quaternion.from_euler(Vector3(PI/2*direction.y, 0, -PI/2*direction.x))
	var new_rotation = move_rotation * player_rotation
	player_rotation = new_rotation
	print(player_pos)
	print(player_rotation.get_euler())
	print("Player Cube Up is now ", player_rotation * Vector3.UP)
	
	# Apply color
	var down_side = round(Vector3.DOWN * player_rotation)
	print(player_colors[Vector3i.UP])
	var down_color = player_colors[down_side]
	if down_color > -1 and down_color != new_tile.color_index:
		paint_tile(new_tile, down_color)
	player_node.rotate_cube(get_player_pos_for_tile(new_tile), player_rotation)
	return true
	
func paint_tile(tile: BoardTileData, color_index: int):
	tile.color_index = color_index
	tile.node.set_color(colors[color_index])

func get_player_pos_for_tile(tile: BoardTileData):
	return Vector3(0, tile_height/2, 0) + tile.node.position
