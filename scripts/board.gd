class_name Board extends Node3D

# Map Info
@export var size: Vector2i = Vector2i(3,3)
@export var start: Vector2i = Vector2i(0,0)
@export var grid_tile_size: Vector2 = Vector2.ONE
@export var colors : Array[Color] = [Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE, Color.PURPLE, Color.LIGHT_GRAY]
@export var tile_height: float = .7

@export_file("*.txt") var level: String

# Prefabs
@export var player_prefab: PackedScene
@export var tile_prefab: PackedScene

# Tracked Data
var tiles: Array[Array]
var goal_colors: Array[Array]
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
	load_level_file(level)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func load_level_file(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	
	# Load Cube Colors
	var cube_colors_text = [file.get_line(), file.get_line(), file.get_line()]
	player_colors[Vector3i.UP] = parse_color_index(cube_colors_text[0][1])
	player_colors[Vector3i.LEFT] = parse_color_index(cube_colors_text[1][0])
	player_colors[Vector3i.BACK] = parse_color_index(cube_colors_text[1][1])
	player_colors[Vector3i.RIGHT] = parse_color_index(cube_colors_text[1][2])
	player_colors[Vector3i.FORWARD] = parse_color_index(cube_colors_text[1][3])
	player_colors[Vector3i.DOWN] = parse_color_index(cube_colors_text[2][1])
	
	file.get_line()
	
	# Load Board Layout
	var board_lines = []
	var curr_line = file.get_line()
	while (curr_line != ""):
		board_lines.append(curr_line)
		curr_line = file.get_line()
	size.y = board_lines.size()
	size.x = 0
	for line in board_lines:
		size.x = max(size.x, len(line))
	var player_tile = null
	for j in board_lines.size():
		var line = board_lines[j]
		var new_row = []
		new_row.resize(size.x)
		tiles.append(new_row)
		for i in len(line):
			var tile_val = line[i]
			match tile_val:
				"P", "o", "S":
					var new_tile = BoardTileData.new()
					new_tile.position = Vector2i(i,j)
					new_tile.color_index = -1
					match tile_val:
						"o":
							new_tile.mode = BoardTileData.TileMode.BASIC
						"S":
							new_tile.mode = BoardTileData.TileMode.SOURCE
					var new_tile_node = tile_prefab.instantiate()
					new_tile_node.name = "Tile (" + str(i) + "," + str(j) + ")"
					new_tile_node.position = Vector3(i*grid_tile_size.x, 0, j*grid_tile_size.y)
					add_child(new_tile_node)
					new_tile_node.set_mode(new_tile.mode)
					new_tile.node = new_tile_node
					tiles[j][i] = new_tile
				" ":
					#logic for spawning walls
					pass
			if tile_val == "P":
				player_pos = Vector2i(i,j)
				player_rotation = Quaternion.IDENTITY
				player_tile = tiles[j][i]
				player_node = player_prefab.instantiate()
				player_node.position = get_player_pos_for_tile(player_tile)
				add_child(player_node)
				for side in player_colors:
					player_node.set_face_color(side, player_colors[side], colors)

	curr_line = file.get_line()
	
	# Load initial tile colors
	var j = 0
	while curr_line != "":
		if j >= size.y: break
		for i in len(curr_line):
			if i >= size.x: break
			if curr_line[i].is_valid_int():
				var tile = tiles[i][j]
				if !tile: continue
				var color = parse_color_index(curr_line[i])
				paint_tile(tile, color)
			
		curr_line = file.get_line()
		j += 1
	
	var down_color = player_colors[Vector3i.DOWN]
	if down_color > -1:
		paint_tile(player_tile, down_color)
		
	curr_line = file.get_line()	
	
	# Load Goal Colors
	goal_colors = []
	goal_colors.resize(size.y)
	j = 0
	while curr_line != "":
		if j >= size.y: break
		var new_row = []
		new_row.resize(size.x)
		goal_colors[j] = new_row
		for i in len(curr_line):
			if i >= size.x: break
			if curr_line[i].is_valid_int():
				var color = parse_color_index(curr_line[i])
				new_row[i] = color
			
		curr_line = file.get_line()
		j += 1
		
	print(goal_colors)
	
func parse_color_index(color: String):
	if color.is_valid_int():
		return int(color)
	return -1
	
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
