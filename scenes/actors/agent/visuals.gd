##
## Contains visual elements of the agent.
##
## All child elements should be added through an AdditionComponent.
##
@tool
@icon("res://assets/icons/classes/Visuals.svg")
class_name AgentVisuals
extends AdditionsContainer

#var _scale_map: Dictionary[Node3D, Vector3] = {}

# =============================================================
# ========= Public Functions ==================================

#static func mark_as_fixed_size(node: Node, fixed: bool = true) -> void:
#node.set_meta(&"fixed_size", fixed)
#
#
#static func is_fixed_size(node: Node) -> bool:
#return node.get_meta(&"fixed_size", false)

# =============================================================
# ========= Callbacks =========================================

#func _ready() -> void:
#set_notify_transform(true)

#func _notification(what: int) -> void:
#if what == NOTIFICATION_TRANSFORM_CHANGED:
#var s: Vector3 = global_transform.basis.get_scale()
#var inv_scale: Vector3 = Vector3(1.0 / s.x, 1.0 / s.y, 1.0 / s.z)
#for node in _scale_map:
#var original_scale: Vector3 = _scale_map[node]
#node.scale = original_scale * inv_scale

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================

#func _on_child_entered_tree(node:  Node) -> void:
#var addition_owners: PackedStringArray = AdditionComponent.get_addition_owners_names(node)
#var components: Node = owner.get_node(Agent.ENTITY_PATH)
#for component_name in addition_owners:
#var component: AdditionComponent = components.get_node(component_name)
#component.add_on_entered_tree(node)
#node.child_entered_tree.connect(_on_child_entered_tree)
#node.child_exiting_tree.connect(_on_child_exiting_tree)
#var node3d: Node3D = node as Node3D
#if node3d and AgentVisuals.is_fixed_size(node):
#_scale_map[node3d] = node3d.scale

#func _on_child_exiting_tree(_node:  Node) -> void:
#pass
#node.child_entered_tree.disconnect(_on_child_entered_tree)
#node.child_exiting_tree.disconnect(_on_child_exiting_tree)
#var node3d: Node3D = node as Node3D
#if node3d and AgentVisuals.is_fixed_size(node):
#if _scale_map.has(node3d):
#_scale_map.erase(node3d)
