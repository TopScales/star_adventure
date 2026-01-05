##
##
@tool
@abstract class_name ActionComponent
extends AnimationComponent

@export var action: BehaviorTree

var _order_stack: Array[Dictionary] = []

@onready var behavior: BTState = owner.get_node(Character.BEHAVIOR_PATH)

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================


func _setup_internal() -> void:
	if Engine.is_editor_hint():
		return
	super._setup_internal()
	var btree: BehaviorTree = behavior.behavior_tree
	var root: BTTask = btree.get_root_task()
	root.add_child(action.get_root_task())


func _finalize_internal() -> void:
	if Engine.is_editor_hint():
		return
	super._finalize_internal()
	var btree: BehaviorTree = behavior.behavior_tree
	var root: BTTask = btree.get_root_task()
	#root.get_child(0).remove_child(action.get_root_task())
	root.remove_child(action.get_root_task())


# =============================================================
# ========= Private Functions =================================


func __add_order(order: Dictionary) -> void:
	_order_stack.push_back(order)


func __prepend_order(order: Dictionary) -> void:
	_order_stack.insert(0, order)


func __clear_stack() -> void:
	_order_stack.clear()


func __get_next_from_stack() -> Dictionary:
	return _order_stack.pop_front()

# =============================================================
# ========= Signal Callbacks ==================================
