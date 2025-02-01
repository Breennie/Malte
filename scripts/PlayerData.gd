extends Node
# On n'a pas besoin de class_name car c'est une scène qui va représenter le joueur

var player_id: int
var player_name: String
var money: float = 500.0  # Montant initial
var cards: Array = []
var is_impostor: bool = false
var is_active: bool = false

# Au lieu d'utiliser _init, on utilise _ready pour l'initialisation
func setup(id: int, name: String):
	player_id = id
	player_name = name

func add_card(card):
	cards.append(card)

func remove_card(card):
	cards.erase(card)

func modify_money(amount: float):
	money += amount
	return money
