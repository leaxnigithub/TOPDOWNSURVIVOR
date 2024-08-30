extends Sprite2D

@onready var tween = Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Tween.interpolate_value(self.modulate.a, 1.0,)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
