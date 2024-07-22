extends Node2D

@onready var texture = $Texture
@onready var area_sign = $Area_sign

const lines : Array[String] =[
	"Olá aventireuro",
	"èmuito bom ve-lo por aqui",
	"espero que esteja preparado",
	"para matar uns trem ai de negocio de coisa",
]

func _unhandled_input(event):
	if area_sign.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !SingletomDialogManager.is_message_active:
			texture.hide()
			SingletomDialogManager.start_message(global_position, lines)
	else:
		texture.hide()
		if SingletomDialogManager.dialog_box != null:
			SingletomDialogManager.dialog_box.queue_free()
			SingletomDialogManager.is_message_active = false
