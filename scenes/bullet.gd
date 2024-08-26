extends Area2D
@onready var player: CharacterBody2D = $player

@export var speed = 10

func _ready() -> void:
	pass
	
func _process(delta):
	translate(Vector2.RIGHT.angle() * speed * delta)
	print
	
