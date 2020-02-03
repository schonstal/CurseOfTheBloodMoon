extends Control

onready var animation = $VBoxContainer/Label/AnimationPlayer

func _ready():
  MusicPlayer.play_file("res://Music/menu.ogg")
  
func _process(delta):
  if Input.is_action_just_pressed("start"):
    animation.play("Flicker")
    Game.reset()
