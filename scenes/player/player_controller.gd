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
	
	# gravity and fall behaviour
	velocity.y += GRAVITY * delta
	velocity.x = lerp(velocity.x, 0.0, FRICTION * delta) 

	# main movement process
	get_input()
	move_and_slide()


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
		
### Input Logic ###
func get_input():
	var cur_speed = abs(velocity.x)
	
	# RUN right
	if Input.is_action_pressed("ui_right") and cur_speed < MAX_SPEED:
		velocity.x += SPEED
	
	# RUN Left
	if Input.is_action_pressed("ui_left") and cur_speed < MAX_SPEED:
		velocity.x -= SPEED
	
	# JUMP
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jump()

func jump():
	velocity.y = -JUMP_SPEED


