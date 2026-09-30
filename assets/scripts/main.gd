extends Node2D

@onready var player = $Player
@onready var hud = $HUD

func _ready() -> void:
	# 1. Connect signal to HUD's update method
	player.stats.health_changed.connect(hud.update_health)
	
	# 2. Set the HUD to full HP immediately when the game starts
	hud.update_health(player.stats.current_health, player.stats.max_health)
