extends Node

const PATHJUGADOR =  "user://saves/jugador/jugador.data"
const PATHSPAWN = "user://saves/vacas/spawn.data"
const PATHANGUS = "user://saves/vacas/angus.data"
const PATHHEREFORD = "user://saves/vacas/hereford.data"
const PATHLIMANGUS = "user://saves/vacas/limangus.data"

var jugador_data:Dictionary = {}
var spawn_vacas_data:Dictionary = {}
var angus_data:Array = []
var hereford_data:Array = []
var limangus_data:Array = []


#func load_game() -> void:
	#
	#if not DirAccess.dir_exists_absolute("user://saves"):
		#print("aun no se a guardado ningun progreso")
	#else:		
		#var save_file_jugador = FileAccess.open(PATHJUGADOR, FileAccess.READ)
		#var save_file_SpawnVacas = FileAccess.open(PATHSPAWN, FileAccess.READ)
		#var save_file_angus = FileAccess.open(PATHANGUS, FileAccess.READ)
		#var save_file_hereford = FileAccess.open(PATHHEREFORD, FileAccess.READ)
		#var save_file_limangus = FileAccess.open(PATHLIMANGUS, FileAccess.READ)
		#
		#var json_string:String = ""
		#var json:JSON = JSON.new()
		#
		## carga del jugador
		#json_string = save_file_jugador.get_line()
		#
		#var check = json.parse(json_string)
		#
		#if not check == OK:
				#print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		#else:
			#jugador_data = json.get_data()
		#save_file_jugador = null
			#
		## fin carga del jugador
		#
		## carga del spwan
		#
		#json_string = save_file_SpawnVacas.get_line()
		#
		#check = json.parse(json_string)
		#
		#if not check == OK:
				#print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		#else:
			#spawn_vacas_data = json.get_data()
		#save_file_SpawnVacas = null
		#
		## fin carga del spwan
		#
		## carga de angus
		 #
		#while save_file_angus.get_position() < save_file_angus.get_length():
			#json_string = save_file_angus.get_line()
			#
			#check = json.parse(json_string)
			#
			#if not check == OK:
				#print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			#else:
				#angus_data.append(json.get_data())
		#save_file_angus = null
		#
		## fin carga angus
		#
		#hereford_data = multi_load(save_file_hereford)
		#save_file_hereford = null
		#limangus_data = multi_load(save_file_limangus)
		#save_file_limangus = null


func multi_load(path:String) -> Array:
	var array_data:Array = []
	var save_file = FileAccess.open(path, FileAccess.READ)
	
	while save_file.get_position() < save_file.get_length():
			var json_string = save_file.get_line()
			var json = JSON.new()
			var check = json.parse(json_string)
			
			if not check == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			else:
				array_data.append(json.get_data())
	save_file = null
	return array_data

func single_load(path:String) -> Dictionary:
	var dictionary:Dictionary = {}
	
	if not DirAccess.dir_exists_absolute("user://saves"):
		print("aun no se a guardado ningun progreso")
	else:		
		var save_file = FileAccess.open(PATHJUGADOR, FileAccess.READ)
		var json_string:String = ""
		var json:JSON = JSON.new()
		
		json_string = save_file.get_line()
		
		var check = json.parse(json_string)
		
		if not check == OK:
				print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		else:
			dictionary = json.get_data()
		save_file = null
	return dictionary

func save_game():
	
	if not DirAccess.dir_exists_absolute("user://saves/jugador"):
		DirAccess.make_dir_absolute("user://saves/jugador")
	if not DirAccess.dir_exists_absolute("user://saves/vacas"):
		DirAccess.make_dir_absolute("user://saves/vacas")
		
	var save_file_jugador = FileAccess.open(PATHJUGADOR, FileAccess.WRITE)
	var save_file_SpawnVacas = FileAccess.open(PATHSPAWN, FileAccess.WRITE)
	var save_file_angus = FileAccess.open(PATHANGUS, FileAccess.WRITE)
	var save_file_hereford = FileAccess.open(PATHHEREFORD, FileAccess.WRITE)
	var save_file_limangus = FileAccess.open(PATHLIMANGUS, FileAccess.WRITE)
	
	var persist_nodes = get_tree().get_nodes_in_group("persist")

	for node in persist_nodes:
		if node.scene_file_path.is_empty():
			print("el nodo persistente " + node.name + " no esta instanciado en la scena, se salteo")
			continue
			
		if not node.has_method("save"):
			print("el nodo persistente " + node.name + " no tiene una funcion save(), se salteo")
			continue
		
		var data_node:Dictionary = node.call("save")
		
		var json_string = JSON.stringify(data_node)
		
		if node.is_in_group("angus"):
			save_file_angus.store_line(json_string)
		elif node.is_in_group("hereford"):
			save_file_hereford.store_line(json_string)
		elif node.is_in_group("limangus"):
			save_file_limangus.store_line(json_string)
		else:
			match node.name:
				"jugador":
					save_file_jugador.store_line(json_string)
				"SpawnVacas":
					save_file_SpawnVacas.store_line(json_string)
		
	
	save_file_jugador = null
	save_file_SpawnVacas = null
	save_file_angus = null
	save_file_hereford = null
	save_file_limangus = null
	
	
	
	
	
	# caga de la partida
	
	#load_game()

func load_jugador() -> void:
	jugador_data = single_load(PATHJUGADOR)

func load_vacas() -> void:
	spawn_vacas_data = single_load(PATHSPAWN)
	angus_data = multi_load(PATHANGUS)
	hereford_data = multi_load(PATHHEREFORD)
	limangus_data = multi_load(PATHLIMANGUS)
