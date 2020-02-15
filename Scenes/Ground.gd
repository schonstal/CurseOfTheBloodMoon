extends TileMap

func _process(delta):
  if Input.is_action_just_pressed("ui_accept"):
    self.visible = !self.visible
