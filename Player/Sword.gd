extends Node2D

export var damage = 10
export var attack_rate = 0.5

var attack_time = 0

onready var sprite = $Sprite
onready var animation = $Sprite/AnimationPlayer
onready var area = $Area2D

func _ready():
  animation.connect("animation_finished", self, "_on_Animation_finished")
  animation.play("Attack")
  area.connect("body_entered", self, "_on_body_enter")
  area.connect("area_entered", self, "_on_body_enter")
  sprite.global_position.y = global_position.y - 50

func _on_Animation_finished(_animation_name):
  queue_free()

func _on_body_enter(body):
  if body.has_method("hurt"):
    EventBus.emit_signal("blood_paid", -100)
    body.hurt(damage)
