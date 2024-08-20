extends CharacterBody2D

var d = 0.0
@export var radius = 50.0 
@export var speed = 2.0
@onready var player = $"."
@onready var mouse_area: Area2D = $mouse_area
@onready var dashtimer = $dashtimer
@onready var animationtree = $AnimationTree
@onready var direction = Vector2.ZERO
@export var SPEED = 100.0
@export var acceleration = 20
@export var FRICTION = 5
@onready var arrow = $arrow
const bullet = preload("res://scenes/bullet.tscn")

func _physics_process(delta) -> void:
	var global_dir := get_local_mouse_position() - to_local(global_position)
	# 2. constraint this position to the radius if it is too big
	if global_dir.length() > radius:
		global_dir = radius * global_dir.normalized()
	else:
		global_dir.normalized()
	# 3. place the constrained object at the calculated position
	arrow.global_position = global_position - global_dir
	
	direction = Input.get_vector("left", "right", "up", "down"). normalized()
	if direction:
		velocity = velocity.move_toward(SPEED * direction, acceleration)
		set_walking(true)
		update_blend_position()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		set_walking(false)
	move_and_slide()
	

func set_walking(value):
	animationtree["parameters/conditions/is_walking"] = value
	animationtree["parameters/conditions/idle"] = not value
	
func update_blend_position():
	animationtree["parameters/IDLE/blend_position"] = direction
	animationtree["parameters/WALK/blend_position"] = direction
	
func shoot():
	var mousepos = get_global_mouse_position()
	if Input.is_action_just_pressed("shoot"):
		arrow.look_at(mousepos)
		


func _on_mouse_area_mouse_entered():
	var mousepos = get_local_mouse_position()
	if mouse_entered:
		print(mousepos)
	else:
		queue_free()
		
func shoot():
