extends Node2D

export var shoot_frequency = 0.05
export var shoot_velocity = 1000

var shoot_time = 0.0

onready var parent = $'..'

var bullet_scene = preload("res://Weapons/MachineGun/Bullet.tscn")

func _process(delta):
  shoot_time -= delta

  if Input.is_action_pressed("shoot"):
    parent.shooting = true
    if shoot_time <= 0:
      spawn_bullet()
      shoot_time = shoot_frequency
  else:
    parent.shooting = false

func spawn_bullet():
  var bullet = bullet_scene.instance()
  Game.scene.bodies.call_deferred("add_child", bullet)
  bullet.global_position = global_position
  bullet.velocity = (parent.aim_direction.normalized() +\
      Vector2(rand_range(0.0, 0.1), rand_range(0, 0.1))) *\
      shoot_velocity * rand_range(0.9, 1)
