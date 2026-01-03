##
##
@tool
extends Node

# =============================================================
# ========= Public Functions ==================================


func get_properties_data(obj: Object, properties: Array[String]) -> Array[Dictionary]:
	var props: Array[Dictionary] = []
	var all_props: Array[Dictionary] = obj.get_property_list()
	for prop in all_props:
		if prop["name"] in properties:
			props.push_back(prop)
	return props


func get_obj_name(obj: Object) -> String:
	if obj is Node:
		return (obj as Node).name
	elif obj is Resource:
		var res: Resource = obj as Resource
		return res.resource_name if not res.resource_name.is_empty() else res.to_string()
	else:
		return obj.to_string()

# =============================================================
# ========= Callbacks =========================================

# =============================================================
# ========= Virtual Methods ===================================

# =============================================================
# ========= Private Functions =================================

# =============================================================
# ========= Signal Callbacks ==================================
