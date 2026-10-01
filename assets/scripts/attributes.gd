class_name Attributes
extends Node

# The signals that the rest of the game will listen to
signal speed_changed(new_speed: float)
signal damage_changed(new_damage: float)
signal cooldown_changed(new_cooldown: float)

@export var strength: int = 10:
	set(value):
		strength = value
		damage_changed.emit(get_damage())

@export var agility: int = 10:
	set(value):
		agility = value
		speed_changed.emit(get_move_speed())

@export var dexterity: int = 10:
	set(value):
		dexterity = value
		cooldown_changed.emit(get_attack_cooldown())

func _ready() -> void:
	# Push the starting numbers out to the movement/combat scripts on frame 1
	speed_changed.emit(get_move_speed())
	damage_changed.emit(get_damage())
	cooldown_changed.emit(get_attack_cooldown())

# --- The Math (Tweak this for balancing later) ---
func get_move_speed() -> float:
	return 100.0 + (agility * 10.0)

func get_damage() -> float:
	return 5.0 + (strength * 2.0)

func get_attack_cooldown() -> float:
	return max(0.2, 1.5 - (dexterity * 0.05))
