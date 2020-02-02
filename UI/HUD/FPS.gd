extends Control

onready var label = $Label

func _process(delta):
  label.set_text("FPS: %s" % str(Engine.get_frames_per_second()))
