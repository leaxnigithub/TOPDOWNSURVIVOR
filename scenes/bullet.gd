extends Area2D
@onready var player: CharacterBody2D = $player
@onready var bullettimer: Timer = $bullettimer
@export var speed = 100
@export var dmg = 2
var delaybetweenshots := 0.4
var bullet_direction
var can_shoot = true

func _ready() -> void:
	pass
	
func _process(delta):
	self.position -= speed * delta * bullet_direction
	
func start_time(duration):
	bullettimer.wait_time = duration
	bullettimer.start()
	
func during_time():
	return !bullettimer.is_stopped()
	
func end_time():
	can_shoot = false
	await(get_tree().create_timer(delaybetweenshots).timeout)
	can_shoot = true
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy") and body.has_method("take_damage"):
		body.take_damage(dmg)
		queue_free()
