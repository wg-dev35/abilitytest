class_name Dummy extends CharacterBody2D

@onready var stats: Stats = $Stats
@onready var sprites: Node2D = $Sprites
@onready var hurtbox: Hurtbox = $Hurtbox

func _ready() -> void:
	# Listen for death signal
	stats.health_depleted.connect(_on_death)
	# Flash red when hit
	stats.dmg_taken.connect(func(): sprites.hitflash(stats.iframe_dur))

func _on_death() -> void:
	print("[DUMMY] Destroyed!")
	queue_free()
