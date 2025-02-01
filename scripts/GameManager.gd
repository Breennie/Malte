extends Node

var players: Array = []
var current_player_index: int = 0
var min_players: int = 4
var max_players: int = 6

var deck: Array = []  # Ajout de la variable deck
var discard_pile: Array = []  # Défausse

var player_scene = preload("res://scenes/player_data.tscn")

signal player_added(player)
signal game_started
signal turn_changed(player)

func initialize_deck():
	# Exemple de carte d'action (statique)
	var reroll_card = ActionCardResource.new()
	reroll_card.type = "Action"
	reroll_card.title = "Reroll"
	reroll_card.texture = preload("res://cartes_images/carte type action - reroll.png")
	reroll_card.effect = "Rejoue le risque d'un investissement"
	deck.append(reroll_card)

	# Exemple de carte d'investissement (valeurs aléatoires)
	for i in range(5):  # Créer 5 cartes d'investissement
		var investment_card = InvestmentCardResource.new()
		investment_card.type = "Investissement"
		investment_card.title = "Investissement"
		investment_card.texture = preload("res://cartes_images/carte type investissement_generique.png")
		
		# Générer des valeurs aléatoires
		investment_card.cost = randi_range(1000, 5000)  # Coût entre 1000$ et 5000$
		investment_card.required_investors = randi_range(2, 4)  # Entre 2 et 4 investisseurs
		investment_card.risk = randi_range(1, 5)  # Risque entre 1 et 5
		investment_card.max_potential_gain = randi_range(2000, 10000)  # Gain entre 2000$ et 10000$
		
		deck.append(investment_card)

	deck.shuffle()  # Mélanger le deck

func display_card(card: CardResource):
	var card_scene
	
	if card is InvestmentCardResource:
		card_scene = preload("res://scenes/scenes_cartes/investment_card_scene.tscn").instantiate()
		card_scene.setup(card)
	elif card is ActionCardResource:
		card_scene = preload("res://scenes/scenes_cartes/action_card_scene.tscn").instantiate()
		card_scene.setup(card)
	elif card is SabotageCardResource:
		card_scene = preload("res://scenes/scenes_cartes/sabotage_card_scene.tscn").instantiate()
		card_scene.setup(card)
	
	add_child(card_scene)

func start_game():
	if players.size() < min_players:
		push_error("Not enough players to start")
		return
		
	initialize_deck()  # Initialiser le deck avant de commencer la partie
	
	# Mélange aléatoire des joueurs
	players.shuffle()
	
	# Sélection aléatoire de l'intru
	var impostor_index = randi() % players.size()
	players[impostor_index].is_impostor = true
	
	# Activation du premier joueur
	players[0].is_active = true
	current_player_index = 0
	
	emit_signal("game_started")
