extends CharacterBody2D

#enum Raza {vaca, colera}
var calidad : int = 5
var nombre : String = "Fernanda"
var raza : String = "Limangus"
var fertilidad : bool = true
const limVelocidad: int = 60
const velocidad : int = 10
var mov: bool = false
var movDireccion: bool = false
var movSentido: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#INICIO DE LOS TIMERS DE 10/3 SEGUNDOS#
	$Movimiento.timeout.connect(movimientoTimeout)

func save() -> Dictionary:
	var save_string = {
		"calidad" = calidad,
		"fertilidad" = fertilidad
	}
	return save_string

func movimientoTimeout() -> void:
	mov = randi()%2
	movDireccion = randi()%2
	movSentido = randi()%2
	$Stooop.start()

func _physics_process(delta) -> void:
	if mov:
		if movDireccion:
			if movSentido:
				velocity.x += velocidad
			else:
				velocity.x += -velocidad
		elif movSentido:
			velocity.y += velocidad
		else:
			velocity.y += -velocidad
###LIMITE DE VELOCIDAD###
		if velocity.x > limVelocidad:
			velocity.x = limVelocidad
		elif velocity.y > limVelocidad:
			velocity.y = limVelocidad
		if velocity.x < -limVelocidad:
			velocity.x = -limVelocidad
		elif velocity.y < -limVelocidad:
			velocity.y = -limVelocidad 

	else:
		velocity.x = int(velocity.x/1.1)
		velocity.y = int(velocity.y/1.1)
	move_and_slide()

""" CODIGO PARA CONVULCIONES ESPONTANEAS
	var direccionX : bool = randi()%2
	var direccionY : bool = randi()%2
	
	if direccionX:
		velocity.x = velocidad
	else:
		velocity.x = (int(direccionX)-1) * (velocidad)
	if direccionY:
		velocity.y = velocidad
	else:
		velocity.y = (int(direccionY)-1) * (velocidad)
	
	move_and_slide()"""


func _on_stooop_timeout():
	mov = false
