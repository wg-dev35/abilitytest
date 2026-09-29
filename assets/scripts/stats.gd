extends Node
class_name Stats

# Signals notify other nodes (like your UI) without needing direct references
signal health_changed(current_health, max_health)
signal health_depleted

@export var max_health: float = 100.0

@onready var current_health: float = max_health:
	set(value):
		current_health = clamp(value, 0, max_health)
		health_changed.emit(current_health, max_health)
		if current_health <= 0:
			health_depleted.emit()

func take_damage(amount: float) -> void:
	current_health -= amount

func heal(amount: float) -> void:
	current_health += amount
