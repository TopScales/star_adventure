##
##
@tool
class_name PlayerShipIntelligence
extends ShipIntelligence

var _moving: bool = false

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	set_process(false)


func _process(_delta: float) -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.is_zero_approx():
		strength = 0.0
		_moving = false
		set_process(false)


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return

	if (
		not _moving and event.is_action("move_up")
		or event.is_action("move_down")
		or event.is_action("move_left")
		or event.is_action("move_right")
	):
		strength = 1.0
		set_process(true)

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
