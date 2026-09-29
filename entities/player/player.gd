class_name Player
extends CharacterBody2D

@onready var stats: Stats = $Stats
@onready var sprites: Node2D = $Sprites


func _ready() -> void:
	stats.health_depleted.connect(_on_death)

func _physics_process(delta: float) -> void:
	sprites.update_animation(velocity)	





#testing
func _unhandled_input(event: InputEvent) -> void:    
	if Input.is_action_just_pressed("ui_accept"): # Spacebar / Enter by default
		stats.take_damage(25)
		
	
	

	
	
func _on_death() -> void:
	print("Game Over")
	queue_free()
