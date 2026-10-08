class_name Hurtbox extends Area2D

@onready var stats: Stats = owner.get_node_or_null("Stats")

func _ready() -> void:
	monitoring = true
	monitorable = false
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	#hitbox check
	if area is Hitbox:
		if area.owner == owner or area.get_parent() == owner or area.get_parent() == get_parent():
			return
				
		if stats and stats.has_method("on_hit"):
			stats.on_hit(area.atkdata)
		print("[HIT] ", owner.name, " took ", " dmg!")
