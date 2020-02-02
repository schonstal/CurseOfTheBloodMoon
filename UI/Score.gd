extends Label

func _process(_delta):
  self.text = "%d" % Game.scene.score
