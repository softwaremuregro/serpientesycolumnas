extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	var escena_jugador_museo = preload("res://TABLERO.tscn")
	get_tree().change_scene_to_packed(escena_jugador_museo)
	pass # Replace with function body.
