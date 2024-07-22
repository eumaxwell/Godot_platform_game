extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction
var is_hurted = false

var knockback_vector := Vector2.ZERO

@onready var animation := $Animated as AnimatedSprite2D
@onready var remote_transform := $RemoteTransform2D as RemoteTransform2D

signal player_has_died()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
		animation.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector		
	_set_state()		
	move_and_slide()
	
	for platforms in get_slide_collision_count():
		var collision = get_slide_collision(platforms)
		if collision.get_collider().has_method("has_collided_with"):
			collision.get_collider().has_collided_with(collision, self)

func _on_hurbox_body_entered(body):
	if $RayCast2D_left.is_colliding():
		take_damage(Vector2(200,-200))
	if $RayCast2D_right.is_colliding():
		take_damage(Vector2(-200,-200))

func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration:= 0.25):
	if Globals.player_life < 1:
		queue_free()
		emit_signal("player_has_died")
	else:
		Globals.player_life -= 1
		if knockback_force != Vector2.ZERO:
			knockback_vector = knockback_force
			
			var knockback_tween := get_tree().create_tween()
			knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
			animation.modulate = Color(1,0,0,1)
			knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		is_hurted = true
		await get_tree().create_timer(.3).timeout
		is_hurted = false

func _input(event):
	if event is InputEventScreenTouch:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

func _set_state():
	var state = "Idle"	
	if is_hurted:
		state = "Hurt"
	elif !is_on_floor():
		state = "Jump"
	elif direction != 0:
		state = "Run"
		
	if animation.name != state:
		animation.play(state)

func _on_area_2d_head_collision_body_entered(body):
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
		else:
			body.animation_player.play("hit")
			body.create_coin()
		
