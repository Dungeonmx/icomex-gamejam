extends CharacterBody2D

func _ready():
	GLOBAL.load_jugador()
	global_position = Vector2(GLOBAL.jugador_data.pos_x, GLOBAL.jugador_data.pos_y)
	print("el jugador esta listo!")

func _physics_process(delta):
	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Multiplica la velocidad por delta para que el movimiento sea consistente
	velocity = direccion * 10000 * delta
	move_and_slide()

func save() -> Dictionary:
	var save_string = {
		"pos_x" = get_global_position().x,
		"pos_y" = get_global_position().y
	}
	return save_string


func _on_button_pressed():
	GLOBAL.save_game()
