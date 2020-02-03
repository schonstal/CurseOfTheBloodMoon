var position:Vector2

var radius = 0.0
var rotation = 0.0
var count = 0
var index = 0
var arc = TAU
var speed
var acceleration

var scene

func _init(options):
  self.position = options["position"]
  self.scene = options["scene"]
  self.count = options["count"]

  if options.has("radius"):
    self.radius = options["radius"]

  if options.has("speed"):
    self.speed = options["speed"]

  if options.has("rotation"):
    self.rotation = options["rotation"]

  if options.has("acceleration"):
    self.acceleration = options["acceleration"]

  if options.has("arc"):
    self.arc = options["arc"]

func should_continue():
  return index < count

func _iter_init(_arg):
  index = 0
  return should_continue()

func _iter_next(_arg):
  index += 1
  return should_continue()

func _iter_get(_arg):
  var bullet = scene.instance()
  var angle = arc * index / count + rotation

  bullet.global_position = position + \
      Vector2(cos(angle), sin(angle)) * \
      radius

  if speed != null:
    bullet.velocity = Vector2(cos(angle), sin(angle)) * speed

  if acceleration != null:
    bullet.acceleration = Vector2(cos(angle), sin(angle)) * acceleration

  Game.scene.bodies.call_deferred("add_child", bullet)

  return bullet
