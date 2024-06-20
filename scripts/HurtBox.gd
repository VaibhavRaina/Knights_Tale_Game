class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", self._on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	# Check if the area is of type HitBox
	if area is HitBox:
		var hitbox = area as HitBox
		if hitbox == null:
			return
		if owner.has_method("take_damage"):
			owner.take_damage(hitbox.damage)
			# Calculate the pushback impulse
			var direction = (owner.global_position - hitbox.global_position).normalized()
			var impulse = direction * 30  # Adjust force magnitude as needed
			owner.apply_pushback(impulse)
