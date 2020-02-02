extends VBoxContainer

onready var try_again = $TryAgainButton
onready var exit = $ExitButton
onready var yes = $YesButton
onready var no = $NoButton
onready var label = $Label
onready var score = $Score

var label_text = ""

func _ready():
  try_again.initialize_focus()

  try_again.connect("pressed", self, "_on_TryAgainButton_pressed")
  exit.connect("pressed", self, "_on_ExitButton_pressed")

  yes.connect("pressed", self, "_on_YesButton_pressed")
  no.connect("pressed", self, "_on_NoButton_pressed")

  label_text = label.text

func _on_TryAgainButton_pressed():
  Game.reset()

func _on_ExitButton_pressed():
  try_again.visible = false
  exit.visible = false
  score.visible = false

  yes.visible = true
  no.visible = true

  label.text = "Are You Sure?"

  no.initialize_focus()

func _on_YesButton_pressed():
  Game.change_scene("res://TitleScreen/TitleScreen.tscn")

func _on_NoButton_pressed():
  try_again.visible = true
  exit.visible = true
  score.visible = true

  yes.visible = false
  no.visible = false

  label.text = label_text

  try_again.initialize_focus()
