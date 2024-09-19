extends Node

var playerhealth = 100
var maxhealth = 100

signal take_damage
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func damage_player(amount):
	playerhealth -= amount
	emit_signal("take_damage")
