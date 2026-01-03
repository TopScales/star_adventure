##
## Execute actions.
##
class_name CharacterController
extends AgentController

const FALL_EVENT: StringName = &"fall"
const STUNNED_EVENT: StringName = &"stunned"
const ACT_EVENT: StringName = &"act"
const DIE_EVENT: StringName = &"die"

# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================

func _ready() -> void:
	initial_state = $Idle
	__init_state_machine()


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

func __init_state_machine() -> void:
	var idle: LimboState = $Idle
	var fall: LimboState = $Fall
	var get_up: LimboState = $GetUp
	var stunned: LimboState = $Stunned
	var behavior: LimboState = $Behavior
	var die: LimboState = $Die

	# Transitions to Idle.
	add_transition(stunned, idle, stunned.EVENT_FINISHED)
	add_transition(get_up, idle, get_up.EVENT_FINISHED)
	add_transition(behavior, idle, &"success")
	add_transition(behavior, idle, &"failure")
	add_transition(die, idle, die.EVENT_FINISHED)

	# Transitions to Fall.
	add_transition(idle, fall, FALL_EVENT)
	add_transition(stunned, fall, FALL_EVENT)
	add_transition(behavior, fall, FALL_EVENT)

	# Transition to GetUp.
	add_transition(fall, get_up, fall.EVENT_FINISHED)

	# Transition to Stunned.
	add_transition(idle, stunned, STUNNED_EVENT)
	add_transition(behavior, stunned, STUNNED_EVENT)

	# Transition to Behavior.
	add_transition(idle, behavior, ACT_EVENT)
	add_transition(get_up, behavior, ACT_EVENT)
	add_transition(stunned, behavior, ACT_EVENT)

	# Transition to Die.
	__add_transition_from_all(die, DIE_EVENT)


# =============================================================
# ========= Signal Callbacks ==================================
