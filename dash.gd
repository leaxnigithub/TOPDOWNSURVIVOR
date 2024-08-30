extends Node2D

var can_dash = true
var dash_delay = 3.0


@onready var Dashtimer = $dashtimer


func start_dash(duration): 
	Dashtimer.wait_time = duration
	Dashtimer.start()

func is_dashing():
	return !Dashtimer.is_stopped()
	
func end_dash():
	can_dash = false
	await(get_tree().create_timer(dash_delay).timeout)
	can_dash = true
	
func _on_dashtimer_timeout():
	end_dash()
