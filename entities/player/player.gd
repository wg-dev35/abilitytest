class_name Player extends CharacterBody2D

@onready var stats: Stats = $Stats
@onready var sprites: Node2D = $Sprites
@onready var movement: TopDownMovement =$Movement
@onready var attributes: Attributes = $Attributes
@onready var moveset: Moveset = $Moveset

##exports
@export var light: AtkData
@export var medium: AtkData
@export var heavy: AtkData

func _ready() -> void:
	#deathcheck
	stats.health_depleted.connect(_on_death)
	#invulerability/hitchecks
	stats.dmg_taken.connect(func(): sprites.hitflash(stats.iframe_dur))
	#atributes
	attributes.speed_changed.connect(movement.speed_effect)
	
	
func _physics_process(delta: float) -> void:
	sprites.update_animation(velocity)	





#testing
func _unhandled_input(event: InputEvent) -> void:    
	if Input.is_action_just_pressed("dash"):
		movement.base_dash()
	elif Input.is_action_just_pressed("jab") and light != null:
		moveset.input_atk(light)
	elif Input.is_action_just_pressed("punch") and medium != null:
		moveset.input_atk(medium)
	elif Input.is_action_just_pressed("kick") and heavy != null:
		moveset.input_atk(heavy)

			
		
	
	

	
	
func _on_death() -> void:
	print("Game Over")
	movement.set_physics_process(false)
	set_physics_process(false)
	set_process(false)
	sprites.playdeath()
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
