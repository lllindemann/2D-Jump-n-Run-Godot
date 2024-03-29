@tool
extends Area2D
class_name Fruit

signal collected

# sprite frames for different fruit types
@export var sprites : Array[SpriteFrames]

var active = true

# Called when the node enters the scene tree for the first time.
# randomize fruits sprit type
func _ready():
	randomize()
	$AnimatedSprite2D.sprite_frames = sprites[randi_range(0, len(sprites)-1)]
	$AnimatedSprite2D.play()

# Reset fruit object to default active state
func reset():
	active = true
	show()
	$CollisionShape2D.disabled = false



func _on_body_entered(body):
	if active and body.get_name() == "player":
		active = false
		
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		
		emit_signal("collected")
