class_name TopDownMovement extends Node

@export var move_speed: float = 300.0
@onready var body: CharacterBody2D = get_parent()
var dashing: bool = false

#deathcheck
var dead: bool = false
func death() -> void:
	dead = true
#status effects
func speed_effect(new_speed: float) -> void:
	move_speed = new_speed

func base_dash(duration: float = 0.2, base:float = 2.5) -> void:
	if dashing or dead:
		return
	dashing = true
	var stats = get_parent().get_node("Stats")
	if stats: stats._start_iframes()
	move_speed *= base
	await get_tree().create_timer(duration).timeout
	move_speed /= base
	dashing = false




#movement
func _physics_process(_delta: float) -> void:
	if not body or dead:
		return
	
	# Handles Keyboard (WASD/Arrows), D-Pad, and Analog Stick smoothly
	var input_direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	body.velocity = input_direction * move_speed
	body.move_and_slide()
