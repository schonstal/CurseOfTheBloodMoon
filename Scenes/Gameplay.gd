extends Node2D

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
var max_combo = 8
var combo_meter = 0.0

func _enter_tree():
  player = $Bodies/Player
  bodies = $Bodies
  sound = $Sound
  game_over_layer = $GameOverLayer
  rain = $Rain

  Game.initialize()

func _ready():
  camera = player.camera
  MusicPlayer.play_file("res://Music/gameplay.ogg")
  EventBus.connect("shake_camera", self, "shake")
  EventBus.connect("game_over", self, "game_over")
  EventBus.connect("reset_combo", self, "reset_combo")
  Engine.time_scale = 1
  reset_score()

func _process(delta):
  if Engine.time_scale < 1:
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
  combo_meter += points

  if combo < max_combo && combo_meter >= 100 * combo:
    combo_meter = 0
    combo += 1
    EventBus.emit_signal("combo_increased", combo)

  score += points * combo

  if score > Game.high_score:
    Game.high_score = score

func reset_combo():
  combo = 1
  combo_meter = 0

func reset_score():
  score = 0
  combo = 1

func shake(duration = 0.5, frequency = 60, amplitude = 25):
  if camera != null:
    camera.shake(duration, frequency, amplitude)
