class_name TopDownMovement
extends CharacterBody2D

@export var move_speed: float = 300.0

func _physics_process(_delta: float) -> void:
	# Handles Keyboard (WASD/Arrows), D-Pad, and Analog Stick smoothly
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = input_direction * move_speed
	
	move_and_slide()
