extends Area2D

var checkpoint_manager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	checkpoint_manager = get_parent().get_parent().get_node("Checkpoint_manager")
	#print(checkpoint_manager)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#pass
		checkpoint_manager.last_location = $Respawn_point.global_position
