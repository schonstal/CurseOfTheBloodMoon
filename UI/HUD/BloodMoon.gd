extends Sprite

onready var animation = $AnimationPlayer

func _ready():
  EventBus.connect("combo_increased", self, "_on_combo_increased")
  EventBus.connect("reset_combo", self, "_on_reset_combo")

func _on_combo_increased(combo):
  if combo >= 2:
    self.visible = true
    self.frame = Game.scene.combo - 2
  else:
    self.frame = 0
    self.visible = false

  if combo >= Game.scene.max_combo:
    self.frame = 8
    animation.play("BloodMoon")

func _on_reset_combo():
  self.frame = 0
  self.visible = false
  animation.play("Idle")
