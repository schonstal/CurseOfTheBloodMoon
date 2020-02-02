extends Control

onready var label = $Label

func _process(delta):
  label.text = "%d" % Game.high_score
