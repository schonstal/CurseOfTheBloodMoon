extends Label


func _ready():
  text = "Score: %s" % Game.scene.score
