extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -900.0
var initial_position: Vector2
@onready var sprite_2d = $Sprite2D
@export var particle: PackedScene

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

func _ready():
	initial_position = global_position

func jump():
	velocity.y = JUMP_VELOCITY
	spawn_particle()

func jump_side(x):
	velocity.y = JUMP_VELOCITY
	velocity.x = x

func _physics_process(delta):
	# Add the gravity.
	if is_on_floor():
		jump_count = 0
		#Animations
		if(velocity.x > 1 || velocity.x < -1):
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "default"
	else:
		velocity.y += gravity * delta
		if jump_count == 2:
			sprite_2d.animation = "double_jumping"
		else:
			sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		if jump_count == 2:
			spawn_particle()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

func spawn_particle():
	var particle_node = particle.instantiate()
	particle_node.position = position
	get_parent().add_child(particle_node)
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
