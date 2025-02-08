extends Node2D

@onready var game_manager = GameManager

func _ready():
	setup_game()

func setup_game():
	# Connecter les signaux
	GameManager.player_added.connect(_on_player_added)
	GameManager.game_started.connect(_on_game_started)
	GameManager.turn_changed.connect(_on_turn_changed)
	GameManager.card_displayed.connect(_on_card_displayed)
	
	# Ajouter des joueurs
	GameManager.add_player("Joueur 1")
	GameManager.add_player("Joueur 2")
	GameManager.add_player("Joueur 3")
	GameManager.add_player("Joueur 4")
	
	# Démarrer la partie
	GameManager.start_game()

func _on_player_added(player: PlayerData):
	print("Nouveau joueur ajouté: ", player.player_name)

func _on_game_started():
	print("La partie commence!")

func _on_turn_changed(player: PlayerData):
	print("C'est au tour de: ", player.player_name)

func _on_card_displayed(card: CardResource):
	print("Carte affichée : ", card.title)
	if card is InvestmentCardResource:
		print("Coût : ", card.cost, "€, Risque : ", card.risk, "/5, Gain max : ", card.max_potential_gain, "€")
	elif card is ActionCardResource:
		print("Effet : ", card.effect)

func _input(event):
	if event.is_action_pressed("ui_accept"):  # Appuyer sur ESPACE pour passer au tour suivant
		GameManager.next_turn()
