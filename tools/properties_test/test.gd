
@tool
extends EditorScript

var TestScript: GDScript = preload("uid://cu46q50bvymps")
var ChildScript: GDScript = preload("uid://jjohe3apck6b")

func _run() -> void:
	var child = ChildScript.new()
	var props = Data.get_properties_info(child, Data.IGNORE_USAGE, [], [], 0, 2)
	child.free()
	var char: CharacterBody2D = null
	print(char.get_class())
