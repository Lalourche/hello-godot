extends Area2D
class_name Player, "res://dodge_assets/art/playerGrey_walk1.png"

signal hit

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# Position	
	position += velocity * delta
	var collisionShape: CapsuleShape2D = $CollisionShape2D.shape
	position.x = clamp(position.x, 0 + collisionShape.radius, screen_size.x - collisionShape.radius)
	position.y = clamp(position.y, 0 + collisionShape.height/2 + collisionShape.radius, screen_size.y - collisionShape.height/2 - collisionShape.radius)

	# Animation
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()  # Player disappears after being hit.
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)
