extends Node2D


# Called when the node enters the scene tree for the first time


## The radius of the constrained area.
@export var radius := 30

@export var constrained_object_path: NodePath
@onready var constrained_object: Node2D = get_node(constrained_object_path)


func _process(_delta: float) -> void:
	# 1. Get the constrained object position relative to the area center
	var global_dir := get_global_mouse_position() - global_position
	# 2. constraint this position to the radius if it is too big
	if global_dir.length() > radius:
		global_dir = radius * global_dir.normalized()
	# 3. place the constrained object at the calculated position
	constrained_object.global_position = global_position + global_dir


func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, Color(1.0, 0.0, 0.0, 0.25))


func set_radius(r):
	radius = r
	queue_redraw() # this triggers a _draw() call.
