class_name Sprites extends Node2D

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_dir: String = "down" 
enum State {IDLE, MOVE, ATTACK, STAGGER, DEAD}
var state: State = State.IDLE
func _ready() -> void:
	anim_sprite.animation_finished.connect(_on_animation_finished)
	
func update_animation(velocity: Vector2) -> void:
	if state in [State.ATTACK, State.STAGGER, State.DEAD]:
		return
	
#IDLE ANIMATION
	if velocity == Vector2.ZERO:
		state = State.IDLE
		var idle: String = "idle-" + last_dir
		anim_sprite.play(idle)
		return
#MOVEMENT DIRECTIONALS <-----IM CONFUSED HERE
	if abs(velocity.x) > abs(velocity.y):
		last_dir = "side"
		scale.x = -1 if velocity.x < 0 else 1
	else:
		scale.x = 1
		last_dir = "up" if velocity.y < 0 else "down"
#WALKING ANIMATON
	state = State.MOVE
	var walking: String = "walk-" + last_dir
	if anim_sprite.animation != walking or not anim_sprite.is_playing():
		anim_sprite.play(walking)
#DEATH ANIMATION
func playdeath() -> void:
	state = State.DEAD
	var death: String = "death-" + last_dir
	anim_sprite.play(death)
#hitflash 
func hitflash(duration: float = 0.8) -> void:
	state = State.STAGGER
	var hit: String = "stagger-" + last_dir
	anim_sprite.play(hit)
	#redflash
	var flash_tween = create_tween()
	anim_sprite.self_modulate = Color(3.0, 0.3, 0.3, 1.0)
	flash_tween.tween_property(anim_sprite, "self_modulate", Color.WHITE, 0.1)
	#iframe transparency
	var time_left = duration - 0.1
	if time_left > 0:
		var loops = int(time_left/0.1)
		var flicker_tween = create_tween().set_loops(loops)
		flicker_tween.tween_property(anim_sprite, "modulate:a",0.3,0.05)
		flicker_tween.tween_property(anim_sprite, "modulate:a",1.0,0.05)
		
		#reset
		flicker_tween.finished.connect(func(): anim_sprite.modulate.a = 1.0)
	
func _on_animation_finished() -> void:
	if state == State.ATTACK or state == State.STAGGER:
		state = State.IDLE
	
func play_atk(atk_type: String) -> void:
	state = State.ATTACK
	var atk_anim: String = atk_type + "-" + last_dir
	anim_sprite.play(atk_anim)
	
