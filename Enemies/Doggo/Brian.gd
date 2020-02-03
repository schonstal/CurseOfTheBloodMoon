extends Node2D

export var speed = 300
export var attack_speed = 3000

onready var player = Game.scene.player
onready var parent = $'..'
onready var sonar_timer = $SonarTimer
onready var detect_box = $DetectBox
onready var animation = $'../Sprite/AnimationPlayer'

var wait = true

func _ready():
  speed = speed * rand_range(0.5, 1.0)
  sonar_timer.connect("timeout", self, "_on_SonarTimer_timeout")

func _on_SonarTimer_timeout():
  wait = !wait

  if wait:
    sonar_timer.wait_time = 0.25
    animation.play("Idle")
    parent.velocity = Vector2.ZERO
    var player = Game.scene.player
  elif Game.scene != null && player != null && is_instance_valid(player) && detect_box.overlaps_body(player):
    sonar_timer.wait_time = 0.5
    animation.play("Attack")
    var direction = Game.scene.player.global_position - global_position
    parent.velocity = attack_speed * direction.normalized()
    print(parent.velocity)
  else:
    sonar_timer.wait_time = 0.25
    animation.play("Idle")
    var direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
    parent.velocity = speed * direction.normalized()
