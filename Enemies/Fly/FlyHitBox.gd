extends Area2D

export var damage = 250.0

onready var parent = $'..'

func _ready():
  connect("body_entered", self, "_on_body_enter")
  connect("area_entered", self, "_on_body_enter")

func _on_body_enter(body):
  if body.has_method("hurt"):
    body.hurt(damage)

  parent.hurt(100)
