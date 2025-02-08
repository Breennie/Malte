extends Control
class_name ActionCard

@onready var effect_label = $EffectLabel
@onready var texture_rect = $TextureRect

func setup(card_data: CardResource):
	print("ActionCard setup called")
	print("effect_label: ", effect_label)
	print("texture_rect: ", texture_rect)

	if card_data is ActionCardResource:
		var action_card_data: ActionCardResource = card_data as ActionCardResource
		texture_rect.texture = card_data.texture
		effect_label.text = action_card_data.effect
	else:
		printerr("Error: Expected ActionCardResource, got ", card_data.get_class())
