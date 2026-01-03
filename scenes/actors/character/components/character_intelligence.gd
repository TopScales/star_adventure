##
## Is the bridge between the external world and the character's logic.
##
## Uses all sensors in Perception node, plus external inputs and notifications
## to clasify the actions that can be executed.
##
@tool
@icon("res://assets/icons/classes/Intelligence.svg")
class_name CharacterIntelligence
extends AnimationComponent

var _controller: CharacterController


# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

func __start_logic() -> void:
	if Engine.is_editor_hint():
		return

	_controller = owner.get_node(Character.CONTROLLER_PATH)
	_controller.initialize(owner)
	_controller.set_active(true)


# =============================================================
# ========= Signal Callbacks ==================================


func _on_entity_notify(what: StringName, cargo: Variant) -> void:
	super._on_entity_notify(what, cargo)
	if what == Entity.NOTIFICATION_SETUP_COMPLETED:
		__start_logic()
