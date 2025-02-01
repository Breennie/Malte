extends Node2D

func _ready():
	setup_game()

func setup_game():
	# On utilise directement GameManager, pas besoin de le créer
	GameManager.player_added.connect(_on_player_added)
	GameManager.game_started.connect(_on_game_started)
	GameManager.turn_changed.connect(_on_turn_changed)
	
	GameManager.add_player("Joueur 1")
	GameManager.add_player("Joueur 2")
	GameManager.add_player("Joueur 3")
	GameManager.add_player("Joueur 4")
	
	GameManager.start_game()

func _on_player_added(player: PlayerData):
	print("Nouveau joueur ajouté: ", player.player_name)

func _on_game_started():
	print("La partie commence!")

func _on_turn_changed(player: PlayerData):
	print("C'est au tour de: ", player.player_name)
