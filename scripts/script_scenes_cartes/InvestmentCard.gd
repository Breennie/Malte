extends Control
class_name InvestmentCard

@onready var cost_label = $CostLabel
@onready var risk_label = $RiskLabel
@onready var gain_label = $GainLabel
@onready var texture_rect = $TextureRect

func setup(card_data: CardResource):
	print("InvestmentCard setup called")
	print("cost_label: ", cost_label)
	print("risk_label: ", risk_label)
	print("gain_label: ", gain_label)
	print("texture_rect: ", texture_rect)

	if card_data is InvestmentCardResource:
		var investment_card_data: InvestmentCardResource = card_data as InvestmentCardResource
		texture_rect.texture = card_data.texture
		cost_label.text = str(investment_card_data.cost)
		risk_label.text = str(investment_card_data.risk)
		gain_label.text = str(investment_card_data.max_potential_gain)
	else:
		printerr("Error: Expected InvestmentCardResource, got ", card_data.get_class())
