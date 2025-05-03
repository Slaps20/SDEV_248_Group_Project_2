extends CanvasLayer

func update_hp(hp, max_hp):
	$Health.text = "HP: " + str(hp) + "/" + str(max_hp) + "\n"

func update_stamina(stamina, max_stamina):
	if stamina < 0:
		$Stamina.text = "Stamina: 0" + "/" + str(max_stamina)
	else:
		$Stamina.text = "Stamina: %d" % stamina + "/" + str(max_stamina)
