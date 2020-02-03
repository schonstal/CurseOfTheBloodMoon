extends Node2D

export var bullet_count = 8
export var bullet_speed = 300.0

onready var timer = $AttackTimer
onready var animation = $'../Sprite/AnimationPlayer'
onready var parent = $'..'

export(Resource) var bullet_scene = preload("res://Enemies/Turret/Projectile.tscn")

func _ready():
  timer.connect("timeout", self, "_on_AttackTimer_timeout")
  animation.connect("animation_finished", self, "_on_Animation_finished")

func _on_AttackTimer_timeout():
  animation.play("Attack")

func _on_Animation_finished(name):
  if name == "Attack":
    animation.play("Idle")

func shoot():
  Util.spawn_full_circle({
      "position": parent.global_position,
      "scene": bullet_scene,
      "count": bullet_count,
      "radius": 40,
      "speed": bullet_speed
    })
