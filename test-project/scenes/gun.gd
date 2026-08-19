extends Area2D

@onready var bullets_container = get_node("/root/Game/Bullets")

var target_enemy:Node2D = null

func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
	else:
		target_enemy = null
		
func shoot():
	if not is_instance_valid(target_enemy):
		return
	const BULLET = preload("res://scenes/bullet.tscn")
	var new_bullet = BULLET.instantiate()
	Audio.shoot_sfx()
	bullets_container.add_child(new_bullet)
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_position.direction_to(target_enemy.global_position).angle()
	
func _on_timer_timeout() -> void:
	shoot()
