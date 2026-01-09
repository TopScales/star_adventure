##
##
@tool
class_name AdditionsContainer
extends Node2D

# =============================================================
# ========= Public Functions ==================================

# =============================================================
# ========= Callbacks =========================================


func _enter_tree() -> void:
	for ichild in get_child_count():
		__register_addition(get_child(ichild))

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================


func __register_addition(addition: Node) -> void:
	var addition_owners: PackedStringArray = AdditionComponent.get_addition_owners_names(addition)
	var components: Node = owner.get_node(Body.ENTITY_PATH)
	for component_name in addition_owners:
		var component: AdditionComponent = components.get_node(component_name)
		if not component.register_addition(addition):
			printerr(
				(
					"Component %s is owner of addition %s, but didn't register it."
					% [component_name, addition.name]
				)
			)

# =============================================================
# ========= Signal Callbacks ==================================
