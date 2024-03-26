extends CharacterBody2D

signal game_over

# variables relevant for main player movement
@export_range(0, 1000, 1) var SPEED : int = 50
@export_range(0, 1000, 1) var MAX_SPEED : int = 150
@export_range(0, 1000, 1) var JUMP_SPEED : int = 400
@export_range(0, 20, 0.01) var FRICTION : float = 10

var GRAVITY : int = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var _sprite2d = $AnimatedSprite2D

# default values for jump and spawn behaviour
var spawn_pos : Vector2 = Vector2.ZERO

### Life-Cycle Functionality ###
# called when main player has been added to the scene
func _ready():
	spawn_pos = position
	setup_anim()

# actions processed on every frame
func _process(_delta):
	process_anim()

# physics processing - actions processed on every frame
func _physics_process(delta):
	# TODO
	pass


### ANIMATION ###
func setup_anim():
	_sprite2d.animation = "idle"
	_sprite2d.play()
	_sprite2d.speed_scale = 1	

func process_anim():
	if abs(velocity.x) >= 20:
		_sprite2d.flip_h = true if velocity.x < 0 else false
	
	if not is_on_floor():
		if velocity.y < 0:
			_sprite2d.play("jump", 1)
		else:
			_sprite2d.play("fall", 1)
	elif abs(velocity.x) >= 20:
		_sprite2d.play("run", velocity.x / MAX_SPEED)
	else:
		_sprite2d.play("idle", 1)

