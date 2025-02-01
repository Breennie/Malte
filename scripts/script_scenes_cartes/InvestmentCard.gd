extends Control

@onready var texture_rect = $TextureRect
@onready var cost_label = $CostLabel
@onready var investors_label = $InvestorsLabel
@onready var risk_label = $RiskLabel
@onready var gain_label = $GainLabel

func setup(card: InvestmentCardResource):
	# Afficher l'image de la carte
	texture_rect.texture = card.texture

	# Afficher les valeurs dynamiques
	cost_label.text = "Coût : %d$" % card.cost
	investors_label.text = "Investisseurs requis : %d" % card.required_investors
	risk_label.text = "Risque : %d/5" % card.risk
	gain_label.text = "Gain max : %d$" % card.max_potential_gain
