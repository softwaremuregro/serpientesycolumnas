extends Node2D

@onready var panel_nombres: Panel = $CanvasLayer/PanelNombres
@onready var input_j1: LineEdit = $CanvasLayer/PanelNombres/InputJ1
@onready var input_j2: LineEdit = $CanvasLayer/PanelNombres/InputJ2
@onready var boton_panel: Button = $CanvasLayer/PanelNombres/Button
@onready var btn_lanzar: TextureButton = $BotonLanzarDado



func _on_comenzar_juego() -> void:
	# Ocultar el panel
	panel_nombres.hide()
	# Activar el botón de lanzar dados
	var mensaje1 = "Jugador 1" if input_j1.text == "" else input_j1.text
	btn_lanzar.nombre_j1 = mensaje1
	
	btn_lanzar.nombre_j2 = "Jugador 2" if input_j2.text == "" else input_j2.text
	
	btn_lanzar.turno.text = "TURNO DE " + mensaje1 
	btn_lanzar.disabled = false
	# Guardar nombres de los jugadores
	
	
	print("Juego iniciado por:", input_j1.text, "y", input_j2.text)

func bloquear_pantalla_horizontal() -> void:
	JavaScriptBridge.eval("""
		function forzarLandscape() {
			if (screen.orientation && screen.orientation.lock) {
				screen.orientation.lock('landscape')
					.then(function() {
						console.log('Pantalla bloqueada en horizontal correctamente.');
					})
					.catch(function(error) {
						console.warn('No se pudo bloquear la orientación automáticamente:', error);
					});
			} else {
				console.log('El navegador no soporta el bloqueo de orientación nativo.');
			}
		}

		// Intentar bloquear de inmediato
		forzarLandscape();

		// Los navegadores a veces exigen que el bloqueo ocurra tras entrar a pantalla completa.
		// Por ello, también lo enganchamos al evento de cambio de pantalla completa.
		document.addEventListener('fullscreenchange', function() {
			if (document.fullscreenElement) {
				forzarLandscape();
			}
		});
	""")
func _on_ready() -> void:
		# Mostrar el panel al inicio
	if OS.has_feature("web"):
		# Ejecutamos código JavaScript para poner el elemento del juego en pantalla completa
		JavaScriptBridge.eval("""
			var canvas = document.getElementById('canvas');
			if (canvas.requestFullscreen) {
				canvas.requestFullscreen();
			} else if (canvas.webkitRequestFullscreen) { /* Safari */
				canvas.webkitRequestFullscreen();
			}
		""")
		bloquear_pantalla_horizontal()
	panel_nombres.show()
	# Desactivar el botón de lanzar dados hasta que se inicie el juego
	btn_lanzar.disabled = true
	pass # Replace with function body.


func _on_btn_atras_pressed() -> void:
	get_tree().change_scene_to_file("res://MENUPRINCIPAL.tscn")
	pass # Replace with function body.


func _on_btn_reiniciar_pressed() -> void:
	get_tree().change_scene_to_file("res://TABLERO2JUGADORES.tscn")
	pass # Replace with function body.


func _on_btn_pantallacompleta_pressed() -> void:
	if OS.has_feature("web"):
		# Ejecutamos código JavaScript para poner el elemento del juego en pantalla completa
		JavaScriptBridge.eval("""
			var canvas = document.getElementById('canvas');
			if (canvas.requestFullscreen) {
				canvas.requestFullscreen();
			} else if (canvas.webkitRequestFullscreen) { /* Safari */
				canvas.webkitRequestFullscreen();
			}
		""")
	else:
		# Código nativo si lo pruebas en PC/Editor
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	pass # Replace with function body.


func _on_btn_salirpantallacompleta_pressed() -> void:
	if OS.has_feature("web"):
		# Código JavaScript para salir del modo web
		JavaScriptBridge.eval("""
			if (document.exitFullscreen) document.exitFullscreen();
			else if (document.webkitExitFullscreen) document.webkitExitFullscreen();
		""")
	else:
		# Código nativo para volver a ventana
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.
