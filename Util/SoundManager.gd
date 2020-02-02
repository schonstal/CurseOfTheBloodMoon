extends Node

onready var player_scene = preload("res://Util/SoundEffect.tscn")

var streams = {}

func play(stream, name = null):
  if name && streams.has(name):
    streams[name].seek(0)
    return

  var player = player_scene.instance()
  player.stream = stream
  player.connect("finished", self, "_on_finished", [name, player])

  if name:
    streams[name] = player

  add_child(player)
  player.play()

func play_scene(scene, name = null):
  if name && streams.has(name):
    streams[name].seek(0)
    return

  var player = scene.instance()
  player.connect("finished", self, "_on_finished", [name, player])

  if name:
    streams[name] = player

  add_child(player)
  player.play()


func _on_finished(name, player):
  player.queue_free()

  if name != null:
    streams.erase(name)
