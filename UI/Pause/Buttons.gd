extends VBoxContainer

onready var resume = $CenterRow/Buttons/ResumeButton
onready var exit = $CenterRow/Buttons/ExitButton

func _ready():
  resume.connect("pressed", self, "_on_ResumeButton_pressed")
  exit.connect("pressed", self, "_on_ExitButton_pressed")

func focus():
  resume.initialize_focus()

func _on_ResumeButton_pressed():
  $'..'.unpause()

func _on_ExitButton_pressed():
  MusicPlayer.disable_filter()
  MusicPlayer.stop()
  Game.change_scene("res://TitleScreen/TitleScreen.tscn")
  get_tree().paused = false
