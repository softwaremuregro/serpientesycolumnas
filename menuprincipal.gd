extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color(1,1,1))

	#if OS.has_feature("web"):
		# Ejecutamos código JavaScript para poner el elemento del juego en pantalla completa
	#	JavaScriptBridge.eval("""
	#		var canvas = document.getElementById('canvas');
	#		if (canvas.requestFullscreen) {
	#			canvas.requestFullscreen();
	#		} else if (canvas.webkitRequestFullscreen) { /* Safari */
	#			canvas.webkitRequestFullscreen();
	#		}
	#	""")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.


func _on_texture_button_pressed2() -> void:
	pass # Replace with function body.
