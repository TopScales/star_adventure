##
##
class_name AnimationState
extends LimboState

@export var animation: StringName = &""

var _ap: AgentAnimationPlayer

# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================


# =============================================================
# ========= Virtual Methods ===================================

func _setup() -> void:
	_ap = owner.get_node("AnimationPlayer")


func _enter() -> void:
	_ap.play(AgentAnimationPlayer.LIBRARY_NAME + "/" + animation)

## Called when state is exited.
#func _exit() -> void:
	#pass

## Called each frame when this state is active.
#func _update(delta: float) -> void:
	#pass


# =============================================================
# ========= Private Functions =================================


# =============================================================
# ========= Signal Callbacks ==================================
