extends Node2D

# how fast the slime moves
@export var speed = 40
# how far the slime walks to the left and to the right of its start place
@export var walk_left = 100.0
@export var walk_right = 100.0
# how many seconds the slime waits at each wall
@export var wait_time = 1.0

# 1 means right, -1 means left
var direction = 1
# true while the slime is standing still
var waiting = false

var left_x = 0.0
var right_x = 0.0

func _ready() -> void:
	# the walls are made from the place where you put the slime
	left_x = position.x - walk_left
	right_x = position.x + walk_right

func _process(delta: float) -> void:
	# do nothing while the slime is waiting
	if waiting:
		return

	# move the slime
	position.x += speed * direction * delta

	# reached the right wall
	if position.x >= right_x:
		position.x = right_x
		direction = -1
		stop_and_wait()

	# reached the left wall
	elif position.x <= left_x:
		position.x = left_x
		direction = 1
		stop_and_wait()

func stop_and_wait() -> void:
	waiting = true
	# wait for some seconds, then start walking again
	await get_tree().create_timer(wait_time).timeout
	waiting = false
