##
##
extends Control


# =============================================================
# ========= Public Functions ==================================


# =============================================================
# ========= Callbacks =========================================

func _ready() -> void:
	Game.standalone_scene = false
	__check_existing_save_files()


# =============================================================
# ========= Virtual Methods ===================================


# =============================================================
# ========= Private Functions =================================

func __check_existing_save_files() -> void:
	pass


# =============================================================
# ========= Signal Callbacks ==================================


func _on_continue_pressed() -> void:
	pass # Replace with function body.


func _on_new_game_pressed() -> void:
	Game.change_main_scene("res://scenes/gui/new_game.tscn")


func _on_load_pressed() -> void:
	Game.change_main_scene("res://scenes/gui/load_game.tscn")


func _on_options_pressed() -> void:
	Game.change_main_scene("res://scenes/gui/options.tscn")


func _on_credits_pressed() -> void:
	Game.change_main_scene("res://scenes/gui/credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
