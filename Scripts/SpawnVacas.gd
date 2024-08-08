extends Node

##LA IDEA ES QUE ESTOS VALORES SE LEAN DE UN ARCHIVO O GRACIAS A OTRO NODO##
var canteleLimangus: int = 8
var canteleHereford: int = 4
var canteleAngus: int = 6
var random = RandomNumberGenerator.new()
@export var height:int
@export var whidth:int
@export var save_area:int

##Cargando Direccion de nodo de las vacas para poder crean instancias##
var addresLimangus = load("res://Escenas/Limangus.tscn")
var addresHereford = load("res://Escenas/Hereford.tscn")
var addresAngus = load("res://Escenas/Angus.tscn")

func _ready():
	
	print($Corral.position)
	
	var i: int = 0
	var posicion: Vector2 = Vector2.ZERO
	while(i < canteleLimangus):
		posicion.x = random.randi_range(save_area, whidth - save_area)
		posicion.y = random.randi_range(save_area, height - save_area)
		var vaka = addresLimangus.instantiate()
		vaka.position = posicion
		$Corral.add_child(vaka)
		i = i+1
	i = 0
	while(i < canteleHereford):
		posicion.x = random.randi_range(save_area, whidth - save_area)
		posicion.y = random.randi_range(save_area, height - save_area)
		var vaka = addresHereford.instantiate()
		vaka.position = posicion
		$Corral.add_child(vaka)
		i = i+1
	i = 0
	while(i < canteleAngus):
		posicion.x = random.randi_range(save_area, whidth - save_area)
		posicion.y = random.randi_range(save_area, height - save_area)
		var vaka = addresAngus.instantiate()
		vaka.position = posicion
		$Corral.add_child(vaka)
		i = i+1

func save() -> Dictionary:
	var save_string = {
		"canteleLimangus" = canteleLimangus,
		"canteleHereford" = canteleHereford,
		"canteleAngus" =  canteleAngus
	}
	return save_string

func _input(event):
	if event is InputEventMouseMotion:
		$Label.set_text(str(event.position))
		
#func _ready():
	
	#print($Corral.position)
	#
	#var i: int = 0
	#var posicion: Vector2
	#while(i < canteleLimangus):
		#posicion = $Corral.global_position
		#posicion.x += random.randi_range(save_area, whidth - save_area)
		#posicion.y += random.randi_range(save_area, height - save_area)
		#var vaka = addresLimangus.instantiate()
		#vaka.global_position = posicion
		#print(vaka.global_position)
		#$Corral.add_child(vaka)
		#i = i+1
	#i = 0
	#while(i < canteleHereford):
		#posicion = $Corral.global_position
		#posicion.x += random.randi_range(save_area, whidth - save_area)
		#posicion.y += random.randi_range(save_area, height - save_area)
		#var vaka = addresHereford.instantiate()
		#vaka.global_position = posicion
		#$Corral.add_child(vaka)
		#i = i+1
	#i = 0
	#while(i < canteleAngus):
		#posicion = $Corral.global_position
		#posicion.x += random.randi_range(save_area, whidth - save_area)
		#posicion.y += random.randi_range(save_area, height - save_area)
		#var vaka = addresAngus.instantiate()
		#vaka.global_position = posicion
		#$Corral.add_child(vaka)
		#i = i+1

