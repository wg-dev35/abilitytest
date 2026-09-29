extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $Sprites/AnimatedSprite2D



func update_animation(velocity: Vector2) -> void:	
	if velocity == Vector2.ZERO:
		anim_sprite.stop()
		return
	var target_anim: String = ""
# Check if horizontal movement is stronger than vertical movement
	if abs(velocity.x) > abs(velocity.y):
		anim_sprite.play("walk-side")
		scale.x = -1 if velocity.x < 0 else 1
	else:
		# Reset scale back to normal when moving up or down
		scale.x = 1
		if velocity.y < 0:
			anim_sprite.play("walk-up")
		elif velocity.y > 0:
			anim_sprite.play("walk-down")
	if anim_sprite.animation != target_anim or not anim_sprite.is_playing():
		anim_sprite.play(target_anim)
