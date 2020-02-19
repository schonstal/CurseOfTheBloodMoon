extends Label

onready var animation = $AnimationPlayer

func _ready():
  EventBus.connect("combo_increased", self, "_on_combo_increased")
  EventBus.connect("reset_combo", self, "_on_reset_combo")
  visible = false

func _on_combo_increased(combo):
  if combo > 1:
    visible = true
    self.text = "x%d" % combo
    animation.play("Combo")

func _on_reset_combo():
  visible = false
