class_name Moveset extends Node
@onready var entity = get_parent()
@onready var stats = entity.get_node("Stats")
@onready var attributes = entity.get_node("Attributes")
@onready var sprites = entity.get_node("Sprites")
var on_cooldown: bool = false


func input_atk(atk_type: String) -> void:
	if on_cooldown == true or sprites.state in [Sprites.State.ATTACK,Sprites.State.STAGGER, Sprites.State.DEAD]:
		return
	var dmg = attributes.get_damage()
	var cd = attributes.get_attack_cooldown()
	sprites.play_atk(atk_type)
	
	match atk_type:
		"punch":
			print("hadoken",dmg)
		"kick":
			print("tatsumaki-senpukuakku",dmg * 1.6)
		"jab":
			print("huh",dmg * 0.8)
	_start_cooldown(cd)

func _start_cooldown(duration: float) -> void:
	on_cooldown = true
	await get_tree().create_timer(duration).timeout
	on_cooldown = false
	
