class_name Sprites extends Node2D
@onready var hitbox: Hitbox = $"../Hitbox"
@onready var hitbox_shape: CollisionShape2D = $"../Hitbox/hitbox_shape"
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_dir: String = "down" 
enum State {IDLE, MOVE, ATTACK, STAGGER, DEAD}
var state: State = State.IDLE

var cur_move: AtkData = null




func _ready() -> void:
	anim_sprite.animation_finished.connect(_on_animation_finished)
	anim_sprite.frame_changed.connect(_on_frame_changed)

func _on_frame_changed() -> void:
	if state!= State.ATTACK or cur_move == null:
		return
			#HITBOX CHECK
	if anim_sprite.frame >= cur_move.active_start and anim_sprite.frame <= cur_move.active_end:
		hitbox_shape.disabled = false
	else:
		hitbox_shape.disabled = true
func _on_animation_finished() -> void:
	if state == State.ATTACK or state == State.STAGGER:
		cur_move = null
		hitbox_shape.disabled = true
		state = State.IDLE

func update_animation(velocity: Vector2) -> void:
	if state in [State.ATTACK, State.STAGGER, State.DEAD]:
		return
	
#IDLE ANIMATION
	if velocity == Vector2.ZERO:
		state = State.IDLE
		var idle: String = "idle-" + last_dir
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
	state = State.MOVE
	var walking: String = "walk-" + last_dir
	if anim_sprite.animation != walking or not anim_sprite.is_playing():
		anim_sprite.play(walking)
#DEATH ANIMATION
func playdeath() -> void:
	state = State.DEAD
	var death: String = "death-" + last_dir
	anim_sprite.play(death)


#####COMBAT####
func play_atk(move: AtkData) -> void:
	state = State.ATTACK
	cur_move = move
	
	match last_dir:
		"side":
			hitbox_shape.position = Vector2(cur_move.reach * scale.x, 0)
		"up":
			hitbox_shape.position = Vector2(0, -cur_move.reach)
		"down":
			hitbox_shape.position = Vector2(0, cur_move.reach)
	
	var atk_anim: String = cur_move.anim + "-" + last_dir
	anim_sprite.play(atk_anim)
	
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
	
	
