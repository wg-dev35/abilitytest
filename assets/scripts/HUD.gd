extends CanvasLayer

@onready var health_bar: TextureProgressBar = $hp_bar

var drain_tween: Tween

func update_health(current_health: float, max_health: float) -> void:
	if max_health <= 0:
		return

	# Set the bar's max capacity to match Stats.max_health
	health_bar.max_value = max_health

	# Kill any active tween so rapid hits don't fight each other
	if drain_tween and drain_tween.is_running():
		drain_tween.kill()

	# Smoothly animate the fill bar value down to current_health over 0.4s
	drain_tween = create_tween()
	drain_tween.tween_property(health_bar, "value", current_health, 0.4)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
