extends Control

@onready var texture_rect = $TextureRect
@onready var effect_label = $EffectLabel

func setup(card: SabotageCardResource):
	texture_rect.texture = card.texture
	effect_label.text = card.effect
