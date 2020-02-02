extends Control

export var title = "Damnation"
export var verse = "Verse One"
onready var title_label = $VBoxContainer/VerseName
onready var verse_label = $VBoxContainer/VerseNumber

func _ready():
  title_label.text = title
  verse_label.text = verse
