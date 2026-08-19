extends Area2D

@onready var player = get_node("/root/Game/Player")


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		Audio.xp_sfx()
		player.add_xp(1)	
		queue_free()
