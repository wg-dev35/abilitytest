class_name Player
extends CharacterBody2D

@onready var stats: Stats = $Stats
@onready var sprites: Node2D = $Sprites
@onready var movement: TopDownMovement =$Movement

func _ready() -> void:
	#deathcheck
	stats.health_depleted.connect(_on_death)
	stats.dmg_taken.connect(func(): sprites.hitflash(stats.iframe_dur))
func _physics_process(delta: float) -> void:
	sprites.update_animation(velocity)	





#testing
func _unhandled_input(event: InputEvent) -> void:    
	if Input.is_action_just_pressed("ui_accept"): # Spacebar / Enter by default
		stats.take_damage(25)
		
	
	

	
	
func _on_death() -> void:
	print("Game Over")
	movement.set_physics_process(false)
	set_physics_process(false)
	set_process(false)
	sprites.playdeath()
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
