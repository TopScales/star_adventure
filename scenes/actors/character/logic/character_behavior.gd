##
class_name CharacterBehavior
extends BTState

@onready var controller: CharacterController = get_parent()

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================


func _ready() -> void:
	add_event_handler(CharacterController.ACT_EVENT, __handle_act)


# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================


func __handle_act(_cargo: Variant = null) -> bool:
	if controller.get_active_state() == self:
		restart()
		return true
	return false

# =============================================================
# ========= Signal Callbacks ==================================
