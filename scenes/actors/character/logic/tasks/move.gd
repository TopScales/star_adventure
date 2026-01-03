##
##
@tool
extends BTAction

var _nav_agent: NavigationAgent3D
var _agent_3d: Node3D
var _speed: float = 1.0
var _prev_target: Vector3 = Vector3.ZERO
var _direction: Vector3 = Vector3.ZERO


# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================


# =============================================================
# ========= Virtual Methods ===================================

func _generate_name() -> String:
	return "Move"


func _setup() -> void:
	_nav_agent = agent.get_node(Character.NAV_AGENT_PATH)
	_agent_3d = agent as Node3D


func _enter() -> void:
	_speed = blackboard.get_var(CharacterMovement.SPEED_VAR, 1.0)
	_agent_3d.look_at(_agent_3d.position - _nav_agent.target_position)


func _exit() -> void:
	_direction = Vector3.ZERO


func _tick(delta: float) -> Status:
	if _nav_agent.is_navigation_finished():
		if _nav_agent.is_target_reached():
			return SUCCESS
		else:
			return FAILURE
	var next: Vector3 = _nav_agent.get_next_path_position()
	if _direction.is_zero_approx() or not next.is_equal_approx(_prev_target):
		_direction = _agent_3d.position.direction_to(next)
		if not is_zero_approx(_direction.x) or not is_zero_approx(_direction.z):
			_agent_3d.look_at(_agent_3d.position - _direction)
	_agent_3d.global_translate(_direction * _speed * delta)
	return RUNNING


# =============================================================
# ========= Private Functions =================================


# =============================================================
# ========= Signal Callbacks ==================================
