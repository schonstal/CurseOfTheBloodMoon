extends Node2D

export(Resource) var ooze_scene = preload("res://Enemies/Leech/Ooze/Ooze.tscn")

func spawn_ooze(rotated):
  var ooze = ooze_scene.instance()
  ooze.global_position = global_position
  # if rotated:
  #  ooze.rotation = PI / 2
  Game.scene.rain.add_child(ooze)
