extends Sprite

func _ready():
  pass
  # Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
 if event is InputEventMouseMotion:
   position = event.position
