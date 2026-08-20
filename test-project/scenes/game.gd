extends Node2D

@onready var player = $Player

func spawn_mob():
	var new_mob = preload("res://scenes/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOverScreen.visible = true
	get_tree().paused = true

func _on_player_leveled_up(level) -> void:
	%LevelLabel.text = "Level: " + str(level)
	$UpgradeScreen.visible = true
	get_tree().paused = true

func _on_upgrade_1_pressed() -> void:
	player.upgrade_move_speed()
	close_upgrade_screen()
	
func _on_upgrade_2_pressed() -> void:
	player.upgrade_damage()
	close_upgrade_screen()

func _on_upgrade_3_pressed() -> void:
	player.upgrade_bullet_speed()
	close_upgrade_screen()

func close_upgrade_screen() -> void:
	$UpgradeScreen.visible = false
	get_tree().paused = false
	
