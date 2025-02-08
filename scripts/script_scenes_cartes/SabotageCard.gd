extends Control
class_name SabotageCard

@onready var effect_label = $EffectLabel
@onready var texture_rect = $TextureRect

func setup(card_data: CardResource):
	print("SabotageCard setup called")
	print("effect_label: ", effect_label)
	print("texture_rect: ", texture_rect)

	if card_data is SabotageCardResource:
		var sabotage_card_data: SabotageCardResource = card_data as SabotageCardResource
		texture_rect.texture = card_data.texture
		effect_label.text = sabotage_card_data.effect
	else:
		printerr("Error: Expected SabotageCardResource, got ", card_data.get_class())
