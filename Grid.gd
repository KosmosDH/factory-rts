extends Node2D

@export var grid_width: int = 10
@export var grid_height: int = 10

@onready var ground: TileMapLayer = $"../Ground"

var previous_cell: Vector2i = Vector2i(-1, -1)


func _process(_delta: float) -> void:
	var current_cell = get_mouse_cell()
	
	if current_cell != previous_cell:
		previous_cell = current_cell
		queue_redraw()


func _draw() -> void:
	if not is_cell_valid(previous_cell):
		return
	var cell_center = ground.to_global(
		ground.map_to_local(previous_cell)
		)
	var cell_position = to_local(cell_center)
	var cell_size = Vector2(ground.tile_set.tile_size)
	
	draw_rect(
		Rect2(cell_position - cell_size / 2.0, cell_size),
		Color(0.2, 0.8, 0.3, 0.4),
		true
	)


func get_mouse_cell() -> Vector2i:
	var mouse_position = ground.to_local(
		get_global_mouse_position()
	)
	return ground.local_to_map(mouse_position)


func is_cell_valid(cell: Vector2i) -> bool:
	return (
		cell.x >= 0 and cell.x < grid_width
		and cell.y >= 0 and cell.y < grid_height
	)
