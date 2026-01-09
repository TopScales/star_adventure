##
@icon("res://assets/icons/classes/ship.svg")
class_name Ship
extends Body

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================

#func _on_child_entered_tree(node:  Node) -> void:
#var addition_owners: PackedStringArray = AdditionComponent.get_addition_owners_names(node)
#var components: Node = $"../Entity"
#for component_name in addition_owners:
#var component: AdditionComponent = components.get_node(component_name)
#component.add_on_entered_tree(node)
##Err.conn(node.child_entered_tree, _on_child_entered_tree)
##Err.conn(node.child_exiting_tree, _on_child_exiting_tree)
#
#
#func _on_child_exiting_tree(_node:  Node) -> void:
#pass
#node.child_entered_tree.disconnect(_on_child_entered_tree)
#node.child_exiting_tree.disconnect(_on_child_exiting_tree)
