class_name ActionStack extends Object

var stack: Array[StackableAction]
var stack_index = 0

func undo():
	if stack_index > 0:
		stack_index -= 1
		var action = stack[stack_index]
		action.undo_changes()
		
func redo():
	if stack_index < stack.size():
		var action = stack[stack_index]
		stack_index += 1
		action.apply_changes()
		
func push_action(action: StackableAction):
	stack.resize(stack_index)
	stack.push_back(action)
	stack_index += 1

class StackableAction:
	var changes: Array[StackableActionChange]
	
	func apply_changes():
		for change in changes:
			change.apply_change()
	
	func undo_changes():
		for change in changes:
			change.undo_change()
	
class StackableActionChange:
	func apply_change():
		pass
	func undo_change():
		pass
		
class PlayerMoveBoardChange extends StackableActionChange:
	var board: Board
	var initial_position: Vector2i
	var initial_rotation: Quaternion
	var new_position: Vector2i
	var new_rotation: Quaternion
	
	func _init(bd: Board, pos_i: Vector2i, rot_i: Quaternion, pos_f: Vector2i, rot_f: Quaternion):
		board = bd
		initial_position = pos_i
		initial_rotation = rot_i
		new_position = pos_f
		new_rotation = rot_f
	
	func set_pos_rot(pos: Vector2i, rot: Quaternion):
		board.deactivate_preview()
		board.player_pos = pos
		board.player_rotation = rot
		var real_pos = board.get_player_pos_for_tile(board.tiles[pos.y][pos.x])
		print("Pos: ", pos, " 3d pos: ", real_pos)
		await board.player_node.rotate_cube(real_pos, rot, .2)
		board.activate_preview()
	
	func apply_change():
		set_pos_rot(new_position, new_rotation)
		
	func undo_change():
		set_pos_rot(initial_position, initial_rotation)
		
class TileColorBoardChange extends StackableActionChange:
	var board: Board
	var tile_position: Vector2i
	var initial_color: int
	var new_color: int
	
	func _init(bd: Board, pos: Vector2i, color_i: int, color_f: int):
		board = bd
		tile_position = pos
		initial_color = color_i
		new_color = color_f
	
	func set_tile_color(pos: Vector2i, color: int):
		print("un/redone tile color: ", color)
		var tile = board.tiles[pos.y][pos.x] as BoardTileData
		tile.color_index = color
		board.paint_tile(tile, color)
		
	func apply_change():
		set_tile_color(tile_position, new_color)
		
	func undo_change():
		set_tile_color(tile_position, initial_color)
		
class PlayerColorBoardChange extends StackableActionChange:
	var board: Board
	var player_side: Vector3i
	var initial_color: int
	var new_color: int
	
	func _init(bd: Board, side: Vector3i, color_i: int, color_f: int):
		board = bd
		player_side = side
		initial_color = color_i
		new_color = color_f
	
	func set_side_color(side: Vector3i, color: int):
		board.player_colors[side] = color
		board.player_node.set_face_color(side, color, board.colors)
		
	func apply_change():
		set_side_color(player_side, new_color)
		
	func undo_change():
		set_side_color(player_side, initial_color)
