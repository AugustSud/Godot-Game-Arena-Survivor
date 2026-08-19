extends Node2D

func play_walk_animation():
	$AnimationPlayer.play("walk")

func play_hurt_animation():
	$AnimationPlayer.play("hurt")
	$AnimationPlayer.queue("walk")
