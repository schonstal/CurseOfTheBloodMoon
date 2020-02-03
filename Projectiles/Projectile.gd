extends Area2D

export var velocity = Vector2(0, -1000)
export var acceleration = Vector2(0, 0)

export var damage = 1
export var rotate_explosion = false

export(Resource) var explosion_scene = preload("res://Projectiles/Explosion.tscn")

onready var sprite = $Sprite
onready var hitbox = $CollisionShape2D

func _ready():
  connect("body_entered", self, "_on_body_enter")
  connect("area_entered", self, "_on_body_enter")
  EventBus.connect("clear_projectiles", self, "_on_clear_projectiles")

  if velocity.length_squared() > 0:
    sprite.rotation = velocity.angle() + PI
    hitbox.rotation = velocity.angle() + PI

func _physics_process(delta):
  velocity += acceleration * delta
  position += velocity * delta

func _process(_delta):
  visible = true

  if velocity.length_squared() > 0:
    sprite.rotation = velocity.angle() + PI
    hitbox.rotation = velocity.angle() + PI

func _on_body_enter(body):
  if body.has_method("hurt"):
    body.hurt(damage)

  die()

func die():
  var explosion = explosion_scene.instance()
  explosion.global_position = global_position
  if rotate_explosion:
    explosion.rotation = rotation - PI / 2
  Game.scene.bodies.call_deferred("add_child", explosion)
  queue_free()

func _on_clear_projectiles():
  die()
