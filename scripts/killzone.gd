extends Area2D

# the timer node that waits before the level restarts
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	# this shows which body touched the killzone
	print("Touched by: ", body.name)
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
