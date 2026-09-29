class_name TopDownMovement
extends Node

@export var move_speed: float = 300.0
@onready var body: CharacterBody2D = get_parent()
func _physics_process(_delta: float) -> void:
	if not body:
		return
	# Handles Keyboard (WASD/Arrows), D-Pad, and Analog Stick smoothly
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	body.velocity = input_direction * move_speed
	
	body.move_and_slide()
