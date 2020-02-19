extends KinematicBody2D

export var run_speed = 300.0
export var max_health = 1000
export var iframe_time = 0.1

var alive = true
var health = 1000
var stunned = false
var invulnerable = false

const RIGHT = -1
const LEFT = 1

var velocity = Vector2(0, 0)
var acceleration = Vector2(0, 0)

var facing = LEFT setget set_facing,get_facing

onready var body = $YSort/Body
onready var animation = $YSort/Body/AnimationPlayer
onready var aim = $YSort/Weapon
onready var iframe_timer = $IframeTimer
onready var camera = $Camera2D
onready var hurtbox = $CollisionShape2D

export(Resource) var explosion_scene = preload("res://Player/PlayerExplosion.tscn")
export(Resource) var hurt_sound = preload("res://Player/SFX/Hurt.ogg")
export(Resource) var die_sound = preload("res://Player/SFX/Death.ogg")

func _ready():
  alive = true
  health = max_health

  iframe_timer.connect("timeout", self, "_on_IframeTimer_timeout")
  animation.connect("animation_finished", self, "_on_Animation_finished")
  EventBus.connect("blood_paid", self, "_on_blood_paid")

func _physics_process(delta):
  if !alive:
    return

  handle_movement()
  update_facing()

  if stunned:
    velocity.x = 0
    velocity.y = 0
  elif velocity.length() > 0:
    animation.play("Run")
  else:
    animation.play("Idle")

  velocity = move_and_slide(velocity)


func update_facing():
  if aim.direction.length() <= 0.4:
    return

  if aim.direction.x < 0:
    self.facing = LEFT
  else:
    self.facing = RIGHT

func handle_movement():
  var direction = Vector2(0, 0)

  direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
  direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

  if direction.length() > 0.3:
    velocity = direction * run_speed
  else:
    velocity = Vector2.ZERO

func _on_blood_paid(amount):
  health -= amount
  if health <= 0:
    die()
  if health >= max_health:
    health = max_health

  EventBus.emit_signal("player_hurt", health)

func hurt(damage):
  if !alive || invulnerable:
    return

  animation.play("Hurt")
  stunned = true
  invulnerable = true

  health -= damage
  if health <= 0:
    die()

  EventBus.emit_signal("player_hurt", health)
  EventBus.emit_signal("shake_camera", 0.25, 60, 20)
  Overlay.fade(Color(0.733, 0.145, 0.192, 0.4), Color(0.733, 0.145, 0.192, 0), 0.3)
  EventBus.emit_signal("reset_combo")
  Game.scene.sound.play(hurt_sound, "player_hurt")

func die():
  alive = false
  visible = false
  hurtbox.disabled = true
  explode()
  Game.scene.sound.play(die_sound, "player_died")
  EventBus.emit_signal("game_over")

func explode():
  var explosion = explosion_scene.instance()
  explosion.global_position = global_position
  explosion.rotation = rotation
  Game.scene.bodies.add_child(explosion)

func set_facing(value):
  if value != RIGHT:
    value = LEFT

  body.apply_scale(Vector2(value * facing, 1))
  facing = value

func get_facing():
  return facing

func _on_Animation_finished(animation_name):
  if animation_name == "Hurt":
    stunned = false
    iframe_timer.start(iframe_time)

func _on_IframeTimer_timeout():
  invulnerable = false
