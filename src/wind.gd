extends Area2D

@onready var player = self.get_parent().get_parent().get_parent().get_node("Player")
@onready var timer = $Timer

var get_out = false
var should_start_timer = true
var wait_time = .1

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	if player.global_position.y > global_position.y + 1:  # Add a small buffer to prevent jitter
		player.velocity.y = lerp(player.velocity.y, -200.0, delta)  # Smooth transition
		player.gravity_on = false
		player.can_shoot = true
	else:
		player.velocity.y = 0  # Stop movement when near the limit
		set_process(false)  # Stop unnecessary updates

func _on_body_entered(body: Node2D) -> void:
	get_out = false
	if body.is_in_group("Player"):
		set_process(true)
		#player.in_wind = true
		
func _on_body_exited(_body: Node2D) -> void:
	if should_start_timer:
		should_start_timer = false
		timer.wait_time = wait_time
		timer.start()
		get_out = true

func _on_timer_timeout() -> void:
	should_start_timer = true
	if get_out:
		set_process(false)
		player.gravity_on = true
