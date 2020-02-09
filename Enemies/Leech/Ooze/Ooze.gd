extends Node2D

onready var animation = $Sprite/AnimationPlayer
onready var lifetime_timer = $LiftetimeTimer

func _ready():
  yield(lifetime_timer, "timeout")
  animation.play("Fade")
  yield(animation, "animation_finished")
  queue_free()
