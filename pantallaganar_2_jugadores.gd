extends Node2D
@onready var lbljugador = $nombreJugador

func _ready():
	RenderingServer.set_default_clear_color(Color(1,1,1))
	lbljugador.text = Global.nombre_jugador
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
