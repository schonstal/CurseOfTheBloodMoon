extends Node

export var max_score = 100000
export var min_score = 0
export var x_range = 950
export var y_range = 550

export(Resource) var enemy_scene = preload("res://Enemies/Bat/Bat.tscn")
export var first_spawn_time = 1.0
export var min_spawn_time = 5.0
export var max_spawn_time = 10.0

onready var spawn_timer = $SpawnTimer

var spawner_scene = preload("res://Enemies/EnemySpawn/Spawner.tscn")

var started = false

# Called when the node enters the scene tree for the first time.
func _ready():
  spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")

func _process(delta):
  if !started && Game.scene.score >= min_score:
    spawn_timer.start(first_spawn_time)
    started = true

func _on_SpawnTimer_timeout():
  var spawn = spawner_scene.instance()

  spawn.global_position = Vector2(
      rand_range(-x_range, x_range),
      rand_range(y_range, -y_range)
    )

  Game.scene.bodies.call_deferred("add_child", spawn)
  spawn.connect("spawn", self, "spawn_enemy")

  var score_percent = (Game.scene.score - min_score) / (max_score - min_score)

  var time = max(
      min_spawn_time,
      max_spawn_time - (max_spawn_time * score_percent)
    )

  spawn_timer.start(time)

func spawn_enemy(position):
  var enemy = enemy_scene.instance()
  enemy.global_position = position
  Game.scene.bodies.call_deferred("add_child", enemy)
