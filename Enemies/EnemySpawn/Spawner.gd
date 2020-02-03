extends Node2D

signal spawn(position)

onready var animation = $Sprite/AnimationPlayer

func _ready():
  animation.connect("animation_finished", self, "_on_Animation_finished")

func _on_Animation_finished(_animation_name):
  queue_free()
  
func spawn():
  emit_signal("spawn", Vector2(global_position.x, global_position.y - 1))
