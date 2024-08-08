extends Area2D

var nueva_posicion = Vector2(128, 420)  # Posición en la casa a la que moveremos al jugador

#func _ready():
	#print("Área en el campo lista y esperando al jugador")
	#if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		#connect("body_entered", Callable(self, "_on_body_entered"))
#
func _on_body_entered(body):
	if body.name == "jugador":
		body.global_position = nueva_posicion

