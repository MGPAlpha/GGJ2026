class_name BoardTileData extends Object

enum TileMode {
	BASIC,
	SOURCE,
	CLEAN,
	INERT
}
	

var position: Vector2i
var color_index: int
var node: Node3D
var mode: TileMode
