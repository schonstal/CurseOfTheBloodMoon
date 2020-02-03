extends Node

var BulletCircle = preload("res://BulletCircle.gd")

# OPTIONS:
# position - global position for center of circle
# scene - scene to spawn
# count - how many to spawn
# radius - radius
# speed - how fast each moves
# rotation - angle (radians) of rotation
func spawn_circle(options):
  return BulletCircle.new(options)

func spawn_full_circle(options):
  for bullet in spawn_circle(options):
    pass
