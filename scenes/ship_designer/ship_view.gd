##
##
@tool
extends Control

@export_range(1.0, 20.0, 0.5) var zoom: float = 1.0: set = set_zoom

@onready var _ship: Node2D = $Ship

# =============================================================
# ========= Public Functions ==================================

func set_zoom(value: float) -> void:
	zoom = value

	if _ship:
		_ship.scale = Vector2(value, value)

# =============================================================
# ========= Built-in Functions ================================

func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		__center_ship()

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

func __center_ship() -> void:
	_ship.position = 0.5 * size

# =============================================================
# ========= Signal Callbacks ==================================
