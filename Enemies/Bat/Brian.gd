extends Node2D

export var speed = 300
export var attack_speed = 3000

onready var player = Game.scene.player
onready var parent = $'..'
onready var sprite = $'../Sprite'
onready var sonar_timer = $SonarTimer
onready var detect_box = $DetectBox
onready var animation = $'../Sprite/AnimationPlayer'

var wait = true

func _ready():
  speed = speed * rand_range(0.5, 1.0)
  sonar_timer.connect("timeout", self, "_on_SonarTimer_timeout")
  parent.connect("hurt", self, "_on_hurt")

func _process(delta):
  if parent.velocity.x > 0:
    sprite.flip_h = true

  if parent.velocity.x < 0:
    sprite.flip_h = false

func _on_SonarTimer_timeout():
  wait = !wait

  if wait:
    animation.play("Idle")
    parent.velocity = Vector2.ZERO
    var player = Game.scene.player
    sonar_timer.start()
  elif Game.scene != null && player != null && is_instance_valid(player) && detect_box.overlaps_body(player):
    animation.play("Attack")
  else:
    animation.play("Idle")
    var direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
    parent.velocity = speed * direction.normalized()
    sonar_timer.start()

func attack_player():
  var direction = Game.scene.player.global_position - global_position
  parent.velocity = attack_speed * direction.normalized()

func stop_attacking():
  parent.velocity = Vector2.ZERO

func idle():
  animation.play("Idle")
  sonar_timer.start()

func _on_hurt():
  sonar_timer.stop()
  animation.play("Stun")
