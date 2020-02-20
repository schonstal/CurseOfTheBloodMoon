extends Node2D

export var play_music = true

var camera:Node
var player:Node
var sound:Node
var bodies:Node
var game_over_layer:Node
var rain:Node

onready var is_game_over = false

var game_over_scene = preload("res://UI/GameOver/GameOver.tscn")
var game_over_node

var score = 0
var combo = 1
var max_combo = 10
var combo_meter = 0.0
var combo_range = 75.0

var combo_percent setget ,get_combo_percent

func _enter_tree():
  player = $Bodies/Player
  bodies = $Bodies
  sound = $Sound
  game_over_layer = $GameOverLayer
  rain = $Rain

  Game.initialize()

func _ready():
  camera = player.camera
  if SaveManager.get_value('high_score') == null:
    Game.high_score = 0
  else:
    Game.high_score = SaveManager.get_value('high_score')

  if play_music:
    MusicPlayer.play_file("res://Music/gameplay.ogg")
  else:
    MusicPlayer.stop()

  EventBus.connect("shake_camera", self, "shake")
  EventBus.connect("game_over", self, "game_over")
  EventBus.connect("reset_combo", self, "reset_combo")
  Engine.time_scale = 1
  reset_score()

func _process(delta):
  if Engine.time_scale < 1:
    if player.alive:
      Engine.time_scale += delta * 15
    else:
      Engine.time_scale += delta * 3
  if Engine.time_scale > 1:
    Engine.time_scale = 1

  if game_over_node == null && is_game_over && Engine.time_scale >= 1:
    game_over_node = game_over_scene.instance()
    game_over_layer.add_child(game_over_node)

func game_over():
  is_game_over = true
  Engine.time_scale = 0.1
  MusicPlayer.enable_filter()

func increment_score(points):
  if !player.alive:
    return

  combo_meter += points

  if combo < max_combo && combo_meter >= combo_range * combo:
    combo_meter = 0
    combo += 1
    EventBus.emit_signal("combo_increased", combo)

  score += points * combo

  if score > Game.high_score:
    Game.high_score = score
    SaveManager.set_value('high_score', score)

func reset_combo():
  combo = 1
  combo_meter = 0

func reset_score():
  score = 0
  combo = 1

func shake(duration = 0.5, frequency = 60, amplitude = 25):
  if camera != null:
    camera.shake(duration, frequency, amplitude)

func get_combo_percent():
  return combo_meter / (combo_range * combo)
