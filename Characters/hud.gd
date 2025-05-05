extends CanvasLayer

func update_hp(hp, max_hp):
	if hp < 0:
		$Health.text = "HP: 0" + "/" + str(max_hp) + "\n"
	else:
		$Health.text = "HP: " + str(hp) + "/" + str(max_hp) + "\n"

func update_stamina(stamina, max_stamina):
	if stamina < 0:
		$Stamina.text = "Stamina: 0" + "/" + str(max_stamina)
	else:
		$Stamina.text = "Stamina: %d" % stamina + "/" + str(max_stamina)
