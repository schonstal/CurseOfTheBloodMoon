extends Label

func _ready():
  text = "Score: %d" % Game.scene.score
