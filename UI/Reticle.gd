extends Node2D

func _process(delta):
  visible = Game.mouse_active
  global_position = get_viewport().get_mouse_position()
