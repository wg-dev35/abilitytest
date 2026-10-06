class_name Hazards extends Area2D


@export var dmg_dealt: float = 25.0
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Stats"):
		var stats = body.get_node("Stats") as Stats
		stats.take_damage(dmg_dealt)
		print("Field Hazard dealt ", dmg_dealt," damage to ",body.name )
