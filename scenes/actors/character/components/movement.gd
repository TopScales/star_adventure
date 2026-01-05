##
##
@tool
@icon("res://assets/icons/classes/Movement.svg")
class_name CharacterMovement
extends ActionComponent

const SPEED_VAR: StringName = &"speed"

var _speed: float = 1.0

@onready var nav_agent: NavigationAgent3D = owner.get_node(Character.NAV_AGENT_PATH)

# =============================================================
# ========= Public Functions ==================================


func go_to(position: Vector3) -> void:
	nav_agent.target_position = position
	if not behavior.dispatch(CharacterController.ACT_EVENT):
		print("GoTo action not consumed.")


# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================


func _setup() -> void:
	behavior.blackboard.set_var(SPEED_VAR, _speed)


# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================


func _on_entity_notify(what: StringName, cargo: Variant) -> void:
	super._on_entity_notify(what, cargo)
	#if what == Persona.NOTIFICATION_TYPE_CHANGED:
	#var type_data: CharacterType = cargo as CharacterType
	#_speed = type_data.speed
