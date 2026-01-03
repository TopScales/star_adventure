##
##
@tool
class_name Health
extends VisualComponent


#@export var hit_points := 100:
	#set(value):
		#if is_inside_tree():
			#hit_points = min(hit_points, max_hit_points)
			#if hit_points <= 0:
				#hit_points = 0
				#_die()
		#else:
			#hit_points = value
#
#var max_hit_points := 100
#
## =============================================================
## ========= Public Functions ==================================
#
#func restore() -> void:
	#hit_points = max_hit_points
#
#
#func get_percentage() -> float:
	#return float(hit_points) / float(max_hit_points)
#
#
## =============================================================
## ========= Callbacks =========================================
#
#func _ready() -> void:
	#super._ready()
	#max_hit_points = hit_points
#
#
## =============================================================
## ========= Virtual Methods ===================================
#
#func _die() -> void:
	#owner.queue_free()


# =============================================================
# ========= Private Functions =================================


# =============================================================
# ========= Signal Callbacks ==================================
