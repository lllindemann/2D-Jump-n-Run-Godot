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
var can_double_jump : bool = true
var just_double_jumped : bool = false
var just_wall_jumped : bool = false


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
	if position.y > 700:
		respawn()
		
	# reset just_double_jumped & just_wall_jumped flag
	just_double_jumped = false
	just_wall_jumped = false

	# gravity and fall behaviour
	velocity.y += GRAVITY * delta
	velocity.x = lerp(velocity.x, 0.0, FRICTION * delta) 
	
	# reset double jump on floor
	if is_on_floor() and velocity.y >= 0:
		can_double_jump = true

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
		if _sprite2d.animation == "double" and _sprite2d.frame != 5:
			return
		if just_double_jumped:
			_sprite2d.play("double", 3)
		if just_wall_jumped:
			_sprite2d.play("wall", 3)
		elif velocity.y < 0:
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
	
	if is_on_wall() and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		velocity.y = -JUMP_SPEED
		velocity.x = 1000
		just_wall_jumped = true
		
	if is_on_wall() and Input.is_action_pressed("ui_up"):
		velocity.y = -JUMP_SPEED * 0.8
		velocity.x = -1000
		just_wall_jumped = true
		
	# RUN Left
	if Input.is_action_pressed("ui_left") and cur_speed < MAX_SPEED:
		velocity.x -= SPEED
	
	# JUMP
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			jump()
		elif can_double_jump:
			jump()
			can_double_jump = false
			just_double_jumped = true

		

func jump():
	velocity.y = -JUMP_SPEED
	

### GAME LOGIC ###
func respawn():
	position = spawn_pos
	velocity.x = 0
	velocity.y = 0 
