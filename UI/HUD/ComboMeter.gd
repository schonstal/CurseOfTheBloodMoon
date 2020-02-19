extends Node2D

var color = Color(0.733, 0.145, 0.192, 1)
var fill_arc = PI / 2
var previous_arc = PI / 2

func _process(delta):
  fill_arc = Game.scene.combo_percent * TAU + PI / 2

  if fill_arc != previous_arc:
    update()

  previous_arc = fill_arc

func _draw():
  draw_arc(
      Vector2.ZERO, # position
      70, # radius
      PI / 2, # start angle
      fill_arc, # end angle
      100, # segments
      color, # color
      20, # width
      true # antialias
    )
