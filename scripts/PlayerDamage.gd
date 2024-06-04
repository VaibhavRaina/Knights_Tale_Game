extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 3

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(Ehitbox: EnemyHitBox) -> void:
	if Ehitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(Ehitbox.damage)
	
