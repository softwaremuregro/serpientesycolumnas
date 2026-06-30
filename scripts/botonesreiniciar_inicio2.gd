extends TextureButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
func _on_btn_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://TABLERO2JUGADORES.tscn")
	pass # Replace with function body.


func _on_btn_inicio_pressed() -> void:
	get_tree().change_scene_to_file("res://MENUPRINCIPAL.tscn")	
	pass # Replace with function body.
