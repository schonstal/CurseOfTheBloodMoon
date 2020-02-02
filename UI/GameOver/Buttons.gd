extends VBoxContainer

onready var try_again = $TryAgainButton
onready var exit = $ExitButton

func _ready():
  try_again.initialize_focus()
  try_again.connect("pressed", self, "_on_TryAgainButton_pressed")

  exit.connect("pressed", self, "_on_ExitButton_pressed")

func _on_TryAgainButton_pressed():
  Game.reset()

func _on_ExitButton_pressed():
  Game.change_scene("res://TitleScreen/TitleScreen.tscn")
