extends Node2D

export var shoot_frequency = 0.05
export var shoot_velocity = 1000

var shoot_time = 0.0

onready var parent = $'..'
onready var audio = $AudioStreamPlayer

var bullet_scene = preload("res://Weapons/MachineGun/Bullet.tscn")

var streams = [
  preload("res://Player/Skull/Skull_Shot_1.ogg"),
  preload("res://Player/Skull/Skull_Shot_2.ogg"),
  preload("res://Player/Skull/Skull_Shot_3.ogg")
]

func _process(delta):
  if !Game.scene.player.alive:
    return

  shoot_time -= delta

  if Input.is_action_pressed("shoot"):
    parent.shooting = true
    if shoot_time <= 0:
      EventBus.emit_signal("blood_paid", 2.0)
      audio.stream = streams[randi() % streams.size()]
      audio.play()
      spawn_bullet()
      shoot_time = shoot_frequency
  else:
    parent.shooting = false

func spawn_bullet():
  var bullet = bullet_scene.instance()
  bullet.global_position = global_position + Vector2(0, 50)
  bullet.velocity = (parent.aim_direction.normalized() +\
      Vector2(rand_range(0.0, 0.1), rand_range(0, 0.1))) *\
      shoot_velocity * rand_range(0.9, 1)
  Game.scene.bodies.call_deferred("add_child", bullet)
