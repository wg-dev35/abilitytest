class_name Moveset extends Node
@onready var entity = get_parent()
@onready var stats = entity.get_node("Stats")
@onready var attributes = entity.get_node("Attributes")
@onready var sprites = entity.get_node("Sprites")
var on_cooldown: bool = false


func input_atk(move: AtkData) -> void:
	if on_cooldown == true or sprites.state in [Sprites.State.ATTACK,Sprites.State.STAGGER, Sprites.State.DEAD]:
		return
	sprites.hitbox.atkdata = move	
	sprites.play_atk(move)
	
	match move.anim:
		"punch":
			print("hadoken")
		"kick":
			print("tatsumaki-senpukuakku")
		"jab":
			print("huh")
	_start_cooldown(attributes.get_attack_cooldown())

func _start_cooldown(duration: float) -> void:
	on_cooldown = true
	await get_tree().create_timer(duration).timeout
	on_cooldown = false
	
