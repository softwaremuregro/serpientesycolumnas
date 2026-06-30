extends TextureButton

@onready var mi_sprite = $"../Dado"
@onready var jugador1 = $"../Jugador1"
@onready var jugador2 = $"../Jugador2"
@onready var nodo_camino = $"../Camino"
@onready var turno = $"../lblTurno"
@onready var button = self
@onready var lbl_titulo : Label = $"../lblTitulo"
@onready var lbl_informacion : Label = $"../lblInformacion"
@onready var imagen_informativa : Sprite2D = $"../imagenInformativa"
@onready var lbl_titulo2 : Label = $"../lblTitulo2"
@onready var lbl_informacion2 : Label = $"../lblInformacion2"
@onready var imagen_informativa2 : Sprite2D = $"../imagenInformativa2"

var posicionJugador =0
var posicionIA = 0
var movimiento_extra = 0
var movimiento_extraIA =0
var titulos_casillas := {
	1: "FACHADA",
	2: "HOJAS DE ACANTO",
	3: "TLALOC",
	4: "BENDICIÓN DE SEMILLAS 2022",
	5: "AUDITORIO 1987",
	6: "ESTATUA DE JOSÉ MARÍA MORELOS Y PAVÓN",
	7: "VASIJA REGIÓN SIERRA",
	8: "REGIÓN NORTE",
	9: "NICHO",
	10: "CORONA Y CALIZ",
	11: "REGIÓN SIERRA",
	12: "TLACOLOLERO",
	13: "GUERRERO JAGUAR AZUL",
	14: "TALLER EDUCATIVO 2013",
	15: "FRONTON TRIANGULAR",
	16: "FUENTE",
	17: "BANDERA TRIGARANTE",
	18: "PORRAZO DEL TIGRE 2023",
	19: "REGIÓN COSTA GRANDE",
	20: "REGIÓN ACAPULCO",
	21: "ATSATSILISTLI",
	22: "ORQUESTA INFANTIL 2026",
	23: "BALCON CON BALAUSTRADA",
	24: "TOPÓNIMO",
	25: "ESCUDO PALACIO DE GOBIERNO",
	26: "VASIJA ROSTRO",
	27: "MURAL CUAUHTÉMOC",
	28: "REGIÓN MONTAÑA",
	29: "REGIÓN TIERRA CALIENTE",
	30: "COLUMNA A ESCALA 2025",
	31: "ARCO DE MEDIO PUNTO",
	32: "CANDIL",
	33: "REGIÓN CENTRO",
	34: "MANTÓN DE MANILA",
	35: "REGIÓN COSTA CHICA",
	36: "COLUMNA JONICA",
}
var textos_casillas := {
	1: "Es el cerramiento exterior de un edificio. Más allá de su estética, es una barrera vital que protege el interior del clima, regula la temperatura (aislamiento térmico) y define la identidad visual de la obra.",
	2: "Son uno de los motivos ornamentales más duraderos en la historia de la arquitectura, inspiradas en la planta mediterránea Acanthus mollis, destacan por sus bordes lobulados y rizados. Su uso clásico más famoso se encuentra en los capiteles del orden corintio.",
	3: "Es el dios mexica de la lluvia, el relámpago y la fertilidad. Venerado como dador de vida y crecimiento agrícola, gobernaba el agua celeste y era temido por su capacidad de enviar sequías o tormentas. ",
	4: "Es un ritual agrícola y espiritual que marca el inicio del ciclo de siembra o el agradecimiento por las cosechas. En México es una tradición ancestral especialmente en Guerrero y otras regiones agrícolas.",
	5: "En 1902 entrando a la derecha se encontraba el gran salón de sesiones del congreso, en 1985 se adaptó para fungir como auditorio de los gobernadores o sala de los gobernadores en nuestro museo y actualmente es el área de usos múltiples.",
	6: "La estatua del general José María Morelos y Pavón se encuentra ubicada en el corazón de la ciudad de Chilpancingo, en la Plaza Cívica Primer Congreso de Anáhuac (Zócalo de Chilpancingo). Este monumento honra al héroe insurgente que instaló el Congreso de Chilpancingo en 1813 y presentó el histórico documento de los Sentimientos de la Nación.",
	7: "Olla tripode tipo rojo y negro sobre crema.Esta vasija se distingue por una compleja composición pictórica bicroma plasmada sobre un engobe de tono crema. La Manufactura de este tipo de piezas está estrechamente ligadas al periodo postclásico tardio(1400-1521d.C.)",
	8: "Es conocida como la 'puerta de entrada' al estado. Limita con el estado de México y Morelos, destacando por su historia minera, colonial y orfebrería. Municipios destacados: Taxco de Alarcón, Iguala de la Independencia, Teloloapan y Huitzuco.",
	9: "Es un hueco o cavidad excavada en el espesor de un muro. Se utiliza tanto con un propósito estético (para exponer esculturas o decoraciones) como funcional (para organizar espacios como duchas o cocinas) y romper con la monotonía de las paredes. ",
	10: "Este acervo corresponde a la museografía de 1987 a 2011, ubicada en la sala de la colonia, piezas utilizadas para el culto religioso (actualmente no está expuesto).",
	11: "Creada oficialmente en 2022 para reconocer las necesidades particulares de las poblaciones de las zonas más altas de la Sierra Madre del Sur. Se extiende transversalmente sobre los municipios de mayor altitud y menor densidad poblacional. Se integra por localidades segregadas de regiones vecinas (incluyendo áreas de Costa Grande, Tierra Caliente y la región Centro).",
	12: "La palabra tlacololero proviene del náhuatl tlacolol, que significa 'terreno en pendiente dedicado al cultivo'. Una danza que escenifica las dificultades que enfrentan los campesinos para sembrar y proteger sus cosechas del 'tigre' (jaguar), que representa los peligros de la naturaleza.",
	13: "Es una representación histórica y mítica de la élite militar mexica, cuyo traje tradicional rinde tributo a los antiguos linajes de guerreros. Este concepto está profundamente arraigado en la historia y el arte del estado de Guerrero.",
	14: "Durante este año se realizaron talleres extramuros: “Un paseo por los museos del INAH en Guerrero” y “Descubriendo una pieza Mezcala”, puesto que el museo estaba en obra por daños estructurales ocasionados por el sismo del 11 de diciembre del 2010.",
	15: "Es el remate clásico de fachadas, pórticos o ventanas, compuesto por una cornisa y un tejado a dos aguas que forman un triángulo. Muy utilizado en la arquitectura griega y romana, su interior (llamado tímpano) suele decorarse con esculturas, relieves o inscripciones.",
	16: "En 1985 cuando se inició la remodelación en el inmueble con el fin de adaptarlo para museo, se colocó una fuente, como la conocemos actualmente. Pepe Gil afirma que en el patio central entre 1951 y 1954 había una escultura de dos manos de gran proporción tallada en cantera.",
	17: "Fue el estandarte utilizado por el Ejército Trigarante en 1821 para consumar la Independencia de México. Es considerada la primera bandera oficial del México independiente y su diseño sentó las bases de nuestra bandera actual.",
	18: "Es una tradicional y ancestral lucha cuerpo a cuerpo originaria de Chilpancingo y Tixtla, Guerrero. Forma parte de las festividades locales especialmente del Paseo del Pendón donde hombres vestidos con trajes de jaguar se enfrentan a empujones y forcejeos hasta derribar a su oponente de espaldas. ",
	19: "Se extiende desde el oeste de Acapulco hasta los límites con Michoacán. Combina playas, llanuras costeras y las laderas de la Sierra Madre del Sur. Municipios destacados: Zihuatanejo, Petatlán, Tecpan y Coyuca de Benítez.",
	20: "Es la región más pequeña territorialmente, pero la más importante a nivel turístico y económico. Se centra exclusivamente en el municipio del mismo nombre, Acapulco de Juárez.",
	21: "En la población nahua de Zitlala existe un mito sobre el origen sagrado del maíz y de la lucha entre tigres. Donde los tigres amarillo y verde son ataviados para la “pelea de tigres” en una representación y actualización de un tema mítico relacionado con el origen de la agricultura.",
	22: "Es una agrupación musical conformada por niños, niñas y jóvenes que interpretan diversas piezas musicales bajo la guía de un director. Estos programas están diseñados para acercar a las infancias a la música clásica o popular, fomentando el aprendizaje instrumental, el trabajo en equipo y el desarrollo social.",
	23: "Es simplemente un balcón cuya barandilla o antepecho de protección está formado por una balaustrada, la cual es una barandilla decorativa compuesta por una serie de pequeñas columnas moldeadas llamadas balaustres. ",
	24: "Según la Real Academia Española (rae), un topónimo es el nombre propio de un lugar. “En las pequeñas avispas coloradas” o en la base de las avispas coloradas” Proveniente de las palabras en lengua náhuatl Chilpan- “avispa colorada”, tzin, tzintli- diminutivo, base, asiento, y co-en.",
	25: "En el Museo Regional de Guerrero tenemos este escudo puesto que se sitúa en un edificio construido en 1902 para albergar el segundo palacio de gobierno y que representa la arquitectura neorrenacentista, representativo de los edificios públicos del Porfiriato.",
	26: "Esta corresponde a la época del preclásico, originario del occidente de México, elaborado de arcilla con método de modelado y cocido, donde se observa una base recta, cuerpo de paredes curvo-divergentes y rostro antropomorfo. ",
	27: "Fue pintado por Roberto Cueva del Río de 1953 a 1954, donde se hace referencia al origen y la importancia de la figura de Cuauhtémoc como símbolo nacional. Pintado en relieve.",
	28: "Es una de las zonas con mayor diversidad étnica y lingüística del país. Es hogar de comunidades indígenas nahuas, mixtecas, tlapanecas y amuzgos. Municipios destacados: Tlapa de Comonfort, Huamuxtitlán, Olinalá y Metlatónoc.",
	29: "Ubicada al noroeste, colinda con Michoacán y el estado de México. Es una zona de valles bajos y clima muy caluroso, famosa por su ganadería, agricultura y su particular músico de arpa (sones calentanos). Municipios destacados: Pungarabato (Ciudad Altamirano), Coyuca de Catalán y Arcelia.",
	30: "En la XII Jornada por la Inclusión dentro del marco del Día Internacional de las Personas con Discapacidad se brindó un taller educativo llamado “Crea y aprende arquitectura”, en el cual se realizaron actividades lúdicas, como la manipulación de la réplica de una columna jónica, elemento característico de la arquitectura neoclásica, que ayuda a mejorar la coordinación óculo-manual. ",
	31: "Es una estructura arquitectónica con forma de media circunferencia que se apoya en dos puntos extremos. Su centro se ubica exactamente en la mitad de la línea horizontal que une ambos apoyos, lo que le permite distribuir el peso de manera uniforme y eficiente.",
	32: "Es un elemento de iluminación, puede referirse a una lámpara colgante decorativa para interiores o, históricamente, a una antigua lámpara portátil de aceite.",
	33: "Es el corazón político y administrativo del estado, situado en el centro del territorio, que combina valles y zonas montañosas. Municipios destacados: Chilpancingo de los Bravo (capital del estado), Tixtla y Chilapa.",
	34: "Este es del primer cuarto del siglo XX siendo de seda bordada con hilos de seda, puesto que el comercio entre nueva españa y filipinas tuvo lugar entre 1565 y 1815, donde una vez al año llegaba a Acapulco el galeón de Manila con artículos de seda, porcelana, marfil y algunos muebles.",
	35: "Es la franja costera que va desde el puerto de Acapulco hasta los límites con Oaxaca. Es reconocida por su gran diversidad cultural, fuerte herencia afromexicana y tradiciones musicales como el son y la chilena. Municipios destacados: Ometepec, Cruz Grande, Ayutla y San Marcos.",
	36: "Es uno de los tres órdenes clásicos de la arquitectura griega (junto al dórico y al corintio). Originaria de Jonia (Asia Menor) en el siglo VI a.C., destaca por su gran elegancia, proporciones esbeltas y por estar rematada con un capitel en forma de espiral o volutas.",
}
func mostrar_informacion2(posicion: int) -> void:
	if(textos_casillas.has(posicion)):
		lbl_informacion2.text = textos_casillas[posicion]
	else:
		lbl_informacion2.text = "Casilla desconocida"
	if(titulos_casillas.has(posicion)):
		lbl_titulo2.text = titulos_casillas[posicion]
	else:
		lbl_titulo2.text = "Casilla desconocida"
	var ruta_imagen = "res://casillas/%d.jpg" % posicion
	var textura = load(ruta_imagen)
	lbl_informacion2.autowrap_mode = TextServer.AUTOWRAP_WORD
	if textura:
		imagen_informativa2.texture = textura
		# Ajustar tamaño fijo (ejemplo: 200x200 px)
		var tamaño_deseado = Vector2(250, 250)
		var actual = imagen_informativa2.texture.get_size()
		imagen_informativa2.scale = tamaño_deseado / actual
	pass
func mostrar_informacion(posicion: int) -> void:
	if(textos_casillas.has(posicion)):
		lbl_informacion.text = textos_casillas[posicion]
	else:
		lbl_informacion.text = "Casilla desconocida"
	if(titulos_casillas.has(posicion)):
		lbl_titulo.text = titulos_casillas[posicion]
	else:
		lbl_titulo.text = "Casilla desconocida"
	var ruta_imagen = "res://casillas/%d.jpg" % posicion
	var textura = load(ruta_imagen)
	lbl_informacion.autowrap_mode = TextServer.AUTOWRAP_WORD
	if textura:
		imagen_informativa.texture = textura
		# Ajustar tamaño fijo (ejemplo: 200x200 px)
		var tamaño_deseado = Vector2(250, 250)
		var actual = imagen_informativa.texture.get_size()
		imagen_informativa.scale = tamaño_deseado / actual
	pass	
	
func _ready():
	"""
	for n in range(1,37):
		mostrar_informacion(n)
		await get_tree().create_timer(2).timeout"""
	RenderingServer.set_default_clear_color(Color(1,1,1))
	"""
	var marcador =  nodo_camino.get_node_or_null(str(7))
	jugador1.position = marcador.position
	posicionJugador = 7
	mostrar_informacion2(7)"""
			
func _on_pressed() -> void:
	lbl_informacion.text=""
	lbl_titulo.text=""
	imagen_informativa.texture = null
	lbl_informacion2.text=""
	lbl_titulo2.text=""
	imagen_informativa2.texture = null
	movimiento_extra = 0
	movimiento_extraIA = 0
	button.disabled = true
	var puntuacion_dado = randi_range(1,6)
	var suma = puntuacion_dado+posicionJugador
	mi_sprite.play(str(puntuacion_dado))
	for n in range (posicionJugador+1,suma+1):
		var marcador =  nodo_camino.get_node_or_null(str(n))
		await get_tree().create_timer(1).timeout
		turno.text = "Jugador Moviendo"
		if marcador:
			jugador1.position = marcador.position
	# Casillas especiales jugador
	if suma==3:
		movimiento_extra = 15
	elif suma==7:
		movimiento_extra = 32
	elif suma==16:
		movimiento_extra = 27
	elif suma==23:
		movimiento_extra = 26
	elif suma==35:
		movimiento_extra = 5
	elif suma == 34:
		movimiento_extra = 22
	elif suma == 19:
		movimiento_extra = 8
	elif suma == 14:
		movimiento_extra = 11

	if movimiento_extra>0:
		mostrar_informacion(suma)
		var marcador = nodo_camino.get_node(str(movimiento_extra))
		await get_tree().create_timer(1).timeout
		jugador1.position = marcador.position
		posicionJugador = movimiento_extra
	else:   
		posicionJugador = suma
	if posicionJugador==posicionIA:
		jugador1.position = jugador1.position + Vector2(-50, 0)
		jugador2.position = jugador1.position + Vector2(80, 0)
	mostrar_informacion2(posicionJugador)
	if posicionJugador>=36:
		get_tree().change_scene_to_file("res://PANTALLAGANAR.tscn")
		return
	# Turno IA
	await get_tree().create_timer(1.5).timeout
	turno.text = "Turno del Museo "
	turno.modulate = Color8(101, 121, 119)
	puntuacion_dado = randi_range(1,6)
	var suma2 = puntuacion_dado+posicionIA
	mi_sprite.play(str(puntuacion_dado))
	for n in range (posicionIA+1,suma2+1):
		var marcador = nodo_camino.get_node_or_null(str(n))
		await get_tree().create_timer(1.5).timeout
		turno.text = "Movimiento del Museo"
		turno.set("custom_colors/font_color", Color8(101, 121, 119)) # Gris
		if marcador:
			jugador2.position = marcador.position
	# Casillas especiales IA
	if suma2==3:
		movimiento_extraIA = 15
	elif suma2==7:
		movimiento_extraIA = 32
	elif suma2==16:
		movimiento_extraIA = 27
	elif suma2==23:
		movimiento_extraIA = 26
	elif suma2==35:
		movimiento_extraIA = 5
	elif suma2 == 34:
		movimiento_extraIA = 22
	elif suma2 == 19:
		movimiento_extraIA = 8
	elif suma2 == 14:
		movimiento_extraIA = 11

	if movimiento_extraIA>0:
		var marcador = nodo_camino.get_node(str(movimiento_extraIA))
		await get_tree().create_timer(1).timeout
		jugador2.position = marcador.position
		posicionIA = movimiento_extraIA
	else:   
		posicionIA = suma2
	if posicionJugador==posicionIA:
		jugador1.position = jugador1.position + Vector2(-50, 0)
		jugador2.position = jugador1.position + Vector2(80, 0)
	# Regresa turno al jugador
	await get_tree().create_timer(1.5).timeout
	turno.text = "Turno del Jugador"
	turno.modulate = Color8(244,191,0)
	turno.set("custom_colors/font_color", Color8(244, 191, 0)) # Amarillo
	button.disabled = false
	if posicionIA>=36:
		get_tree().change_scene_to_file("res://PANTALLAPERDISTE.tscn")
		return
	pass
	
