extends CharacterBody2D

var health = 3

@onready var player = get_node("/root/Game/Player")
@onready var xp_container = get_node("/root/Game/XPContainer")
const XP_GEM = preload("res://scenes/xp.tscn")

func _ready() -> void:
	%Mob.play_walk_animation()

func _physics_process(_delta: float) -> void:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 200
		move_and_slide()

func take_damage():
	health -= 1
	%Mob.play_hurt_animation()
	
	if health <= 0:
		var new_xp_gem = XP_GEM.instantiate()
		new_xp_gem.global_position = global_position
		xp_container.add_child.call_deferred(new_xp_gem)
		queue_free()
		
	
