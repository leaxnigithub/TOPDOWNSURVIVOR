extends CharacterBody2D
@export var SPEED := 10
const TIMER = 2
const BLOOD = preload("res://scenes/blood.tscn")
@export var health = 10
@onready var enemy : Sprite2D = $sprite
@onready var player = get_tree().get_first_node_in_group("player")
@onready var timer = $area/damagetimer
const Playerstats = preload("res://singletons/Playerstats.gd")
const DAMAGE = 5
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
				timer.start()
				print("hit!")
				get_tree().quit()
				
				
	else:
		return

func take_damage(damage):
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a", 0, 0.03 )
	tween.tween_property(self,"modulate:s", 100, 0.03 )
	tween.tween_property(self,"modulate:a", 1, 0.05)
	tween.tween_property(self,"modulate:s", 0, 0.01)
	health -= damage
	if health <= 0:
		queue_free()
		var bloodspill = BLOOD.instantiate()
		bloodspill.global_position = global_position
		add_sibling(bloodspill)
