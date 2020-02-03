extends Node2D

export var speed = 1000
export var attack_speed = 3000

onready var parent = $'..'
onready var detect_box = $DetectBox
onready var animation = $'../Sprite/AnimationPlayer'
onready var player = Game.scene.player

var facing = LEFT setget set_facing,get_facing

const RIGHT = -1
const LEFT = 1

func _process(delta):
  if Game.scene != null && player != null && is_instance_valid(player):
    if detect_box.overlaps_body(player):
      animation.play("Attack")
      parent.acceleration = Vector2.ZERO
      parent.velocity = Vector2.ZERO
    else:
      var direction = Game.scene.player.global_position - global_position
      parent.acceleration = attack_speed * direction.normalized()
      if player.position.x < position.x:
        self.facing = LEFT
      else:
        self.facing = RIGHT

func set_facing(value):
  if value != RIGHT:
    value = LEFT

  parent.apply_scale(Vector2(value * facing, 1))
  facing = value

func get_facing():
  return facing
