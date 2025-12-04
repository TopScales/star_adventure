##
@tool
@icon("res://assets/icons/classes/game.svg")
extends Node

@export var version: Version

@onready var settings: Settings = $Settings
@onready var debug: Debug = null

var standalone_scene: bool = true


# =============================================================
# ========= Public Functions ==================================

func change_main_scene(path: String, initial_data: Dictionary[StringName, Variant] = {}) -> void:
	# TODO: Add loading scene.
	#if Err.checkerr(get_tree().change_scene_to_file(path)):
	if get_tree().change_scene_to_file(path) == OK:
		await get_tree().scene_changed
		var scene := get_tree().current_scene
		for prop in initial_data:
			var value: Variant = initial_data[prop]
			scene.set(prop, value)


# =============================================================
# ========= Callbacks =========================================

func _ready() -> void:
	randomize()
	if Engine.is_editor_hint() and version:
		ProjectSettings.set_setting("application/config/version", version.get_as_string(false, false))
	if OS.is_debug_build():
		pass


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================


# =============================================================
# ========= Signal Callbacks ==================================
