extends CharacterBody2D
const SPEED := 20.0

@onready var enemy : Sprite2D = $sprite
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer = $area/damagetimer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * SPEED
	check_player()
	move_and_slide()

func check_player():
	if timer.is_stopped():
		pass
	var collisions = $area.get_overlapping_bodies()
	if collisions:
		for collision in collisions:
			if collision.is_in_group("player") and timer.is_stopped():
				print("hit!")
	else:
		return
