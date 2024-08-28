extends CharacterBody2D
const dashspeed = 500.0
const time = 0.3
@export var radius = 50.0 
@export var speed := 20
@onready var player = $"."
@onready var mouse_area: Area2D = $mouse_area
@onready var animationtree = $animation_sorter
@onready var direction = Vector2.ZERO
@export var SPEED = 100.0
@export var acceleration = 20
@export var FRICTION = 5
@onready var arrow := $arrow2
const BULLET = preload("res://scenes/bullet.tscn")
@onready var world = get_node('/root/world')
@onready var dash: Node2D = $dash

func _physics_process(delta) -> void:
	
	if Input.is_action_just_pressed("dash"):
		dash.start
	if Input.is_action_just_pressed("shoot"):
		shoot(delta)
		
	var global_dir := get_local_mouse_position() - to_local(global_position) * 10
	# 2. constraint this position to the radius if it is too big
	if global_dir.length() > radius:
		global_dir = radius * global_dir.normalized()
	else:
		global_dir = radius * global_dir.normalized()
	# 3. place the constrained object at the calculated position
	arrow.global_position = global_position - global_dir
	arrow.look_at(position)
		
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
	animationtree["parameters/RUN/blend_position"] = direction
	
func _on_mouse_area_mouse_entered():
	var mousepos = get_local_mouse_position()
	if mouse_entered:
		print(mousepos)
	else:
		queue_free()
		
func shoot(delta):
		var bulletshot = BULLET.instantiate()
		bulletshot.global_position = global_position
		bulletshot.bullet_direction = -(to_local(position) - get_local_mouse_position().normalized() * speed)
		get_parent().add_child(bulletshot) 
	
