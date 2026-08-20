extends CharacterBody2D

@onready var gun = $Gun

signal health_depleted
signal leveled_up

var speed := 300
var health = 100.0
var xp: int = 0
var level: int = 1

func _physics_process(delta: float) -> void:
	get_damage(delta)
	movement()
	
func movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	if velocity.length() > 0.0:
		%AngryCube.play_walk_animation()
	else:
		%AngryCube.play_idle_animation()

func get_damage(delta):
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%HealthBar.value = health
		if health <= 0.0:
			Audio.game_over_sfx()
			health_depleted.emit()
			
func add_xp(amount: int):
	xp += amount
	if xp >= %XPBar.max_value:
		level_up()
	%XPBar.value = xp
	
func level_up():
	Audio.level_up_sfx()
	xp = 0
	%XPBar.value = 0
	animated_text()
	level += 1
	leveled_up.emit(level)

func animated_text():
	var message = %LevelUpMessage
	message.modulate.a = 1.0
	message.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(message, "modulate:a", 0, 1)

func upgrade_move_speed():
	speed *= 1.05
	
func upgrade_damage():
	gun.damage += 1
	
func upgrade_bullet_speed():
	gun.bullet_speed *= 1.1
