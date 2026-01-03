##
##
@icon("res://assets/icons/classes/Controller.svg")
class_name AgentController
extends LimboHSM

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================


func __add_transition_from_all(
	to: LimboState, event: StringName, blacklist: Array[LimboState] = []
) -> void:
	for istate in get_child_count():
		var state: LimboState = get_child(istate) as LimboState
		if not blacklist.has(state):
			add_transition(state, to, event)


func __add_finished_event_from_all(to: LimboState, blacklist: Array[LimboState] = []) -> void:
	for istate in get_child_count():
		var state: LimboState = get_child(istate) as LimboState
		if not blacklist.has(state):
			add_transition(state, to, state.EVENT_FINISHED)

# =============================================================
# ========= Signal Callbacks ==================================
