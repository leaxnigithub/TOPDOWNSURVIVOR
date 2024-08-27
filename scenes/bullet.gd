extends Area2D
@onready var player: CharacterBody2D = $player

@export var speed = 100
var bullet_direction

func _ready() -> void:
	pass
	
func _process(delta):
	position -= speed * delta * bullet_direction
	
