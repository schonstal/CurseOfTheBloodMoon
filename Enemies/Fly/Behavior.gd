extends Node2D

export var speed = 300
onready var parent = $'..'
onready var sprite = $'../Sprite'

func _process(delta):
  var direction = Game.scene.player.global_position - global_position
  parent.velocity = speed * direction.normalized()

  if parent.velocity.x > 0:
    sprite.flip_h = true

  if parent.velocity.x < 0:
    sprite.flip_h = false
