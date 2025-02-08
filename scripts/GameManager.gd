extends Node

var players: Array = []
var current_player_index: int = 0
var min_players: int = 4
var max_players: int = 6

var deck: Array = []
var discard_pile: Array = []

var player_scene = preload("res://scenes/player_data.tscn")

signal player_added(player)
signal game_started
signal turn_changed(player)
signal card_displayed(card)

func _ready():
	initialize_deck()  # Initialiser le deck au démarrage pour les tests

func add_player(name: String):
	if players.size() >= max_players:
		push_error("Maximum number of players reached")
		return null
		
	var player = player_scene.instantiate()
	player.setup(players.size(), name)
	add_child(player)
	players.append(player)
	emit_signal("player_added", player)
	return player

func initialize_deck():
	# Cartes d'investissement aléatoires
	for i in range(5):
		var investment_card = InvestmentCardResource.new()
		investment_card.type = "Investissement"
		investment_card.title = "Investissement %d" % (i + 1)
		investment_card.texture = preload("res://cartes_images/carte type investissement_generique.png")
		investment_card.cost = randi_range(1000, 5000)
		investment_card.required_investors = randi_range(2, 4)
		investment_card.risk = randi_range(1, 5)
		investment_card.max_potential_gain = randi_range(2000, 10000)
		deck.append(investment_card)

	# Cartes d'action fixes
	var reroll_card = ActionCardResource.new()
	reroll_card.type = "Action"
	reroll_card.title = "Reroll"
	reroll_card.texture = preload("res://cartes_images/carte type action - reroll.png")
	reroll_card.effect = "Rejoue le risque d'un investissement"
	deck.append(reroll_card)

	# Cartes de sabotage fixes
	var vol_card = SabotageCardResource.new()
	vol_card.type = "Sabotage"
	vol_card.title = "Vol"
	vol_card.texture = preload("res://cartes_images/carte type sabotage - vol.png")
	vol_card.effect = "Vole de l'argent"
	deck.append(vol_card)

	deck.shuffle()

func start_game():
	if players.size() < min_players:
		push_error("Not enough players to start")
		return
	
	players.shuffle()
	var impostor_index = randi() % players.size()
	players[impostor_index].is_impostor = true
	players[0].is_active = true
	current_player_index = 0
	
	# Test : Afficher 3 cartes au démarrage
	for i in range(3):
		display_random_card()
	
	emit_signal("game_started")

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
	
	if card_scene:
		#card_scene.position = Vector2(200 * get_tree().get_nodes_in_group("cards").size(), 50)
		add_child(card_scene)
		emit_signal("card_displayed", card)

func display_random_card():
	if deck.size() > 0:
		var random_index = randi() % deck.size()
		display_card(deck[random_index])

func next_turn():
	players[current_player_index].is_active = false
	current_player_index = (current_player_index + 1) % players.size()
	players[current_player_index].is_active = true
	
	# Test : Piocher et afficher une carte à chaque tour
	var active_player = players[current_player_index]
	var drawn_card = deck.pop_front() if deck.size() > 0 else null
	if drawn_card:
		active_player.add_card(drawn_card)
		display_card(drawn_card)
	
	emit_signal("turn_changed", active_player)
