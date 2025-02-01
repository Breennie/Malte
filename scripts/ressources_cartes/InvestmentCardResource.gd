extends CardResource
class_name InvestmentCardResource

@export var cost: float  # Coût pour participer à l'investissement
@export var required_investors: int  # Nombre minimum de joueurs requis
@export var invest_min: int  # Somme minimale à investir
@export var risk: int  # Niveau de risque (ex: 1 à 5)
@export var max_potential_gain: float  # Gain maximum potentiel
