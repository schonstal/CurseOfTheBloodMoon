extends Node2D

var camera:Node
var player:Node
var sound:Node
var bodies:Node
var game_over_layer:Node

onready var is_game_over = false

var game_over_scene = preload("res://UI/GameOver/GameOver.tscn")
var game_over_node

var score = 0

func _enter_tree():
  camera = $Camera2D
  player = $Bodies/Player
  bodies = $Bodies
  sound = $Sound
  game_over_layer = $GameOverLayer

  Game.initialize()

func _ready():
  MusicPlayer.play_file("res://Music/gameplay.ogg")
  EventBus.connect("shake_camera", self, "shake")
  EventBus.connect("game_over", self, "game_over")
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
  score += points

  if score > Game.high_score:
    Game.high_score = score

func reset_score():
  score = 0

func shake(duration = 0.5, frequency = 60, amplitude = 25):
  if camera != null:
    camera.shake(duration, frequency, amplitude)
