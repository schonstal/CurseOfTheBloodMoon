extends Button

onready var selectors = $Selectors
onready var selector_left = $Selectors/Left
onready var selector_right = $Selectors/Right
onready var label = $Label

onready var focus_sound = $Focus
onready var click_sound = $Click
var play_focus_sound = true

func _ready():
  self.connect("focus_entered", self, "_on_focus_entered")
  self.connect("focus_exited", self, "_on_focus_exited")
  self.connect("mouse_entered", self, "_on_mouse_entered")
  self.connect("pressed", self, "_on_pressed")

  var font = label.get_font("font")

  var text_size = font.get_string_size(label.text)
  var text_width = text_size.x + 150

  selector_left.position.x = (rect_size.x - text_width) / 2
  selector_right.position.x = (rect_size.x + text_width) / 2

  selector_left.position.y = rect_size.y / 2
  selector_right.position.y = rect_size.y / 2

func _on_focus_entered():
  selectors.visible = true

  if play_focus_sound:
    focus_sound.play()

  play_focus_sound = true

func _on_focus_exited():
  selectors.visible = false

func _on_mouse_entered():
  grab_focus()

func _on_pressed():
  click_sound.play()

func initialize_focus():
  play_focus_sound = false
  grab_focus()
