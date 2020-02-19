extends Control

onready var animation = $VBoxContainer/Label/AnimationPlayer

var started = false

func _ready():
  MusicPlayer.play_file("res://Music/menu.ogg")

func _process(_delta):
  if !started && Input.is_action_just_pressed("start"):
    started = true
    animation.play("Flicker")
    Game.reset()
