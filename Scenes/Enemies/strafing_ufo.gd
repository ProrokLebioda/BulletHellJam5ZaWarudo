extends EnemyBase

@onready var direction_change_timer = $Timers/DirectionChangeTimer

var side_dir : Vector2 = Vector2.RIGHT
var time_to_dir_change : float = 2.0

func _ready():
	dir = Vector2.DOWN + side_dir
	direction_change_timer.start(time_to_dir_change)
	
func shoot():
	if can_shoot:
		for mount in weapon_mounts_node.get_children():
			# change direction to one going for player?
			var wp = mount.get_child(0) as WeaponBase
			var projectiles = wp.fire(mount.global_position, Vector2.DOWN)
			for projectile in projectiles:
				enemy_shoot.emit(mount.global_position,Vector2.DOWN, projectile)
			
		can_shoot = false
		weapon_timer.start(weapon_cooldown)

func _on_direction_change_timer_timeout():
	side_dir *= -1
	dir = Vector2.DOWN + side_dir
