extends Area2D

signal collected

var active = true

func _on_body_entered(body):
	if active and body.get_name() == "player":
		active = false
		
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		
		emit_signal("collected")

func reset():
	active = true
	show()
	$CollisionShape2D.set_deferred("disabled", false)
