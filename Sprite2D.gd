extends Sprite2D

var d = 0.0
@export var radius = 150.0
@export var speed = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
	d += delta

	position = Vector2( 
		sin(d * speed) * radius,
		cos(d * speed) * radius
	) + get_global_mouse_position()
