class_name GoalDisplay extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var colors: Array[Array]
var goal_colors

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _draw():
	var bounds = get_rect()
	
	draw_rect(Rect2(Vector2.ZERO, bounds.size),Color(Color.GRAY,.4))
	if !goal_colors: return
	var tiles_width = goal_colors[0].size()
	var tiles_height = goal_colors.size()
	var dx = bounds.size.x/tiles_width
	var dy = bounds.size.y/tiles_height
	var d = min(dx,dy)
	var start_pos = bounds.size/2.0 - d * Vector2(tiles_width, tiles_height) / 2.0
	for j in goal_colors.size():
		for i in goal_colors[j].size():
			var color_index = goal_colors[j][i]
			var color: Color = colors[color_index][0] if color_index != null and color_index > -1 else Color.WHITE 
			draw_rect(Rect2(start_pos + Vector2(i*d,j*d), Vector2(d,d)), color)


func _on_goal_set(goal_colors: Array[Array], colors: Array[Array]) -> void:
	self.goal_colors = goal_colors
	self.colors = colors
	queue_redraw()
	
