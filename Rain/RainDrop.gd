extends Node2D

onready var animation = $Sprite/AnimationPlayer
onready var sprite = $Sprite

var color:Color = Color(1, 1, 1, 0.2)

func _ready():
  animation.connect("animation_finished", self, "_on_Animation_finished")
  sprite.modulate = color

func _on_Animation_finished(_animation_name):
  queue_free()
