extends Node2D

export(Resource) var rain_scene = preload("res://Rain/Rain.tscn")

func spawn_rain():
  var rain = rain_scene.instance()
  rain.global_position = global_position
  Game.scene.rain.add_child(rain)
