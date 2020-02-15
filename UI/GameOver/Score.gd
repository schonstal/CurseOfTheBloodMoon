extends Label

func _ready():
  text = "Score: %s" % Util.thousands_string(Game.scene.score)
