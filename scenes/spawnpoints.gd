extends Node2D

@onready var timer: Timer = $Timer
@onready var enemyspots = $enemyspots.get_children()
@onready var world = get_node("/root/world")
const ENEMY = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func spawn_enemy():
	var enemy = ENEMY.instantiate()
	var spawnpoints = enemyspots.pick_random()
	enemy.global_position = spawnpoints.global_position
	world.add_child(enemy)
	

func _on_timer_timeout() -> void:
	spawn_enemy()
