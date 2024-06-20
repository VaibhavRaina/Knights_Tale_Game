extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 3

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	# Check if the area is of type EnemyHitBox
	if area is EnemyHitBox:
		var Ehitbox = area as EnemyHitBox
		if Ehitbox == null:
			return
		if owner.has_method("take_damage"):
			owner.take_damage(Ehitbox.damage)
