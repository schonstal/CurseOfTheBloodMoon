tool
extends Node2D

onready var flash_tween = $FlashTween
onready var grow_tween = $GrowTween

onready var bar = $Bar
onready var back = $Back
onready var max_amount = 100

onready var container = $Container
var color = Color(0.733, 0.145, 0.192, 1)

export var bar_length = 700
onready var original_bar_length = bar_length

var length_scale = 1
var active = false
var percent = 0.0

func _ready():
  if Engine.editor_hint:
    return

  max_amount = Game.scene.player.max_health
  bar.color = color

  EventBus.connect("player_hurt", self, "_on_player_hurt")
  percent = 1.0

  grow_tween.interpolate_property(
      self,
      "bar_length",
      0,
      original_bar_length,
      2,
      Tween.TRANS_QUAD,
      Tween.EASE_OUT)

  grow_tween.start()

func _process(_delta):
  var fill_length = bar_length + 122
  if bar != null:
    bar.rect_size.x = percent * fill_length
    back.rect_size.x = fill_length
    container.length = bar_length

func update_bar(amount):
  percent = float(amount) / max_amount

func _on_player_hurt(health):
  flash_tween.interpolate_property(
      bar,
      "modulate",
      Color(10, 10, 10, 1),
      color,
      0.3,
      Tween.TRANS_QUART,
      Tween.EASE_OUT)

  flash_tween.start()

  update_bar(health)
