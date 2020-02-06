extends AudioStreamPlayer

var bullet_scene = preload("res://Weapons/MachineGun/Bullet.tscn")

var streams = [
  preload("res://Player/SFX/Step_1.ogg"),
  preload("res://Player/SFX/Step_2.ogg"),
  preload("res://Player/SFX/Step_3.ogg"),
  preload("res://Player/SFX/Step_4.ogg")
]

func play_step_sound():
  self.stream = streams[randi() % streams.size()]
  self.play()
