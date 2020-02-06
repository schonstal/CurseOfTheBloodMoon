extends Node2D

export var speed = 1000

onready var parent = $'..'
onready var detect_box = $DetectBox
onready var sight = $Sight
onready var animation = $'../Sprite/AnimationPlayer'
onready var player = Game.scene.player

var attacking = false
var saw_player = false

var facing = LEFT setget set_facing,get_facing

const RIGHT = -1
const LEFT = 1

func _ready():
  animation.connect("animation_finished", self, "_on_Animation_finished")
  sight.connect("body_entered", self, "_on_Sight_body_entered")

func _process(delta):
  if Game.scene == null || player == null:
    return

  if is_instance_valid(player) && !attacking:
    if detect_box.overlaps_body(player):
      attacking = true
      animation.play("Attack")
      parent.acceleration = Vector2.ZERO
      parent.velocity = Vector2.ZERO
    elif saw_player:
      animation.play("Run")
      var direction = Game.scene.player.global_position - global_position
      parent.acceleration = speed * direction.normalized()
      if player.global_position.x < global_position.x:
        self.facing = LEFT
      else:
        self.facing = RIGHT
    else:
      animation.play("Idle")

func set_facing(value):
  if value != RIGHT:
    value = LEFT

  parent.apply_scale(Vector2(value * facing, 1))
  facing = value

func get_facing():
  return facing

func _on_Animation_finished(name):
  if name == "Attack":
    attacking = false

func _on_Sight_body_entered(body):
  saw_player = true
