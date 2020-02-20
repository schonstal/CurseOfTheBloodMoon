extends Node

export var max_score = 100000
export var min_score = 0
export var x_range = 950
export var y_range = 550

export var max_group_size = 1
export var min_group_size = 1

export(Resource) var enemy_scene = preload("res://Enemies/Bat/Bat.tscn")
export var first_spawn_time = 1.0
export var min_spawn_time = 5.0
export var max_spawn_time = 10.0

export var radial = false

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
  var score_percent = float(Game.scene.score - min_score) / float(max_score - min_score)

  var group_size = int(min(
      lerp(min_group_size, max_group_size, score_percent),
      max_group_size
    ))

  create_spawns(group_size)

  var time = max(
      min_spawn_time,
      max_spawn_time - (max_spawn_time * score_percent)
    )

  spawn_timer.start(time)

func create_spawns(group_size):
  for index in range(0, group_size):
    var spawn = spawner_scene.instance()

    if radial:
      var angle = TAU * index / group_size
      var radius = 500

      spawn.global_position = Game.scene.player.global_position + \
          Vector2(cos(angle), sin(angle)) * \
          radius
    else:
      spawn.global_position = Vector2(
          rand_range(-x_range, x_range),
          rand_range(y_range, -y_range)
        )

    spawn.global_position.x = clamp(spawn.global_position.x, -x_range, x_range)
    spawn.global_position.y = clamp(spawn.global_position.y, -y_range, y_range)

    Game.scene.bodies.call_deferred("add_child", spawn)
    spawn.connect("spawn", self, "spawn_enemy")

func spawn_enemy(position):
  var enemy = enemy_scene.instance()
  enemy.global_position = position
  Game.scene.bodies.call_deferred("add_child", enemy)
