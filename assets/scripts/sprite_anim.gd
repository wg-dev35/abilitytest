extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

var last_dir: String = "down"
func update_animation(velocity: Vector2) -> void:	
#IDLE ANIMATION
	if velocity == Vector2.ZERO:
		var idle: String = "idle-" + last_dir
		if anim_sprite.animation != idle:
			anim_sprite.play(idle)
		return
#MOVEMENT DIRECTIONALS
	if abs(velocity.x) > abs(velocity.y):
		last_dir = "side"
		scale.x = -1 if velocity.x < 0 else 1
	else:
		scale.x = 1
		last_dir = "up" if velocity.y < 0 else "down"
#WALKING ANIMATON
	var walking: String = "walk-" + last_dir
	if anim_sprite.animation != walking or not anim_sprite.is_playing():
		anim_sprite.play(walking)
#DEATH ANIMATION
func playdeath() -> void:
	var death: String = "death-" + last_dir
	anim_sprite.play(death)
