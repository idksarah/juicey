extends CharacterBody2D

var pos:Vector2
var x_pos_offset = 20 # bullet spawn logic doesn't accoutn for up down or varying shooting positions
var y_pos_offset = 10
var dir : float
var x_vector = 1
var y_vector = 1
var multiplier = 500

var reg_timer = 1
var stopped = false

@onready var timer = $Area2D/Timer
@onready var stop_timer = $Area2D/StopTimer
@onready var collision = $Area2D/CollisionShape2D

func _ready() -> void:
	global_position = Vector2(pos.x + x_pos_offset, pos.y + y_pos_offset)
	timer.start()
	
func _process(delta: float) -> void:
	pass
	
func _on_timer_timeout():
	queue_free()

func _on_stop_timer_timeout():
	stopped = true

func _physics_process(delta: float):
	velocity = Vector2(x_vector * multiplier, y_vector * multiplier)
	if stopped:
		velocity = Vector2(0,0)
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body.name == "Player":
		return
	queue_free()
