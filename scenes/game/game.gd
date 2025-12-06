##
@tool
@icon("res://assets/icons/classes/game.svg")
extends Node

const LOADING_SCREEN_PATH: String = "res://scenes/game/loading_screen.tscn"

@export var version: Version

@onready var settings: Settings = $Settings
@onready var debug: Debug = null

var standalone_scene: bool = true

var _loading_path: String = ""
var _initial_data: Dictionary[StringName, Variant] = {}


# =============================================================
# ========= Public Functions ==================================

func change_main_scene(path: String, use_loading_screen: bool = false, initial_data: Dictionary[StringName, Variant] = {}) -> void:
	if Err.fail(_loading_path.is_empty(), "Can't change main scene while loading another scene.", "Game"):
		return

	if use_loading_screen:
		if Err.success_err(get_tree().change_scene_to_file(LOADING_SCREEN_PATH), "Can't open loading screen.", "Game"):
			await get_tree().scene_changed
			var err: int = ResourceLoader.load_threaded_request(path, "PackedScene", true)
			if Err.success_err(err, "Error while trying to load scene in the background.", "Game"):
				_loading_path = path
				_initial_data = initial_data
				set_process(true)
	elif Err.success_err(get_tree().change_scene_to_file(path), "Can't open main scene.", "Game"):
		await get_tree().scene_changed
		__initialize_scene(initial_data)


# =============================================================
# ========= Callbacks =========================================

func _ready() -> void:
	randomize()
	set_process(false)
	if Engine.is_editor_hint() and version:
		ProjectSettings.set_setting("application/config/version", version.get_as_string(false, false))
	if OS.is_debug_build():
		pass


func _process(_delta: float) -> void:
	var progress: Array = [0]
	var status: int = ResourceLoader.load_threaded_get_status(_loading_path, progress)

	match status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			Log.error("Background loading tried to load an invalid scene.")
			_loading_path = ""
			_initial_data.clear()
			set_process(false)
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			var loading_screen: LoadingScreen = get_tree().current_scene
			loading_screen.set_progress(progress[0])
		ResourceLoader.THREAD_LOAD_FAILED:
			Log.error("Background loading failed to load the scene.")
			_loading_path = ""
			_initial_data.clear()
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			set_process(false)
			var scene: PackedScene = ResourceLoader.load_threaded_get(_loading_path)
			if Err.success_err(get_tree().change_scene_to_packed(scene), "Can't change main scene."):
				await  get_tree().scene_changed
				__initialize_scene(_initial_data)
			_loading_path = ""
			_initial_data.clear()


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

func __initialize_scene(initial_data: Dictionary[StringName, Variant]) -> void:
	standalone_scene = false
	var scene: Node = get_tree().current_scene

	for prop in initial_data:
		var value: Variant = initial_data[prop]
		scene.set(prop, value)


# =============================================================
# ========= Signal Callbacks ==================================
