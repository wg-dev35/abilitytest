extends Node
class_name Stats

# Signals notify other nodes (like your UI) without needing direct references
signal health_changed(current_health, max_health)
signal health_depleted
signal dmg_taken

@export var max_health: float = 100.0
@export var iframe_dur: float = 0.8

var invincibility: bool = false

@onready var current_health: float = max_health:
	set(value):
		#1 deathcheck
		var im_dead = (current_health <= 0)
		#
		current_health = clamp(value, 0, max_health)
		health_changed.emit(current_health, max_health)
		if current_health <= 0 and not im_dead:
			health_depleted.emit()
func _ready() -> void:
	health_changed.emit(current_health,max_health)
  
func take_damage(amount: float) -> void:
	#iframe invul
	if invincibility or current_health <= 0:
		return
		
	current_health -= amount
	#iframe trigger if we live
	if current_health > 0:
		dmg_taken.emit()
		_start_iframes()

func _start_iframes() -> void:
	invincibility = true
	await get_tree().create_timer(iframe_dur).timeout
	invincibility = false

func heal(amount: float) -> void:
	current_health += amount
