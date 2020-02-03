extends Node2D

onready var animation = $Sprite/AnimationPlayer

func _ready():
  animation.connect("animation_finished", self, "_on_Animation_finished")

func _on_Animation_finished(_animation_name):
  queue_free()
