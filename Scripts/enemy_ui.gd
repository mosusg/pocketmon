extends Node2D

@onready var pokemonSprite = $pokemon
@onready var levelText = $BottomFrameThing/level
@onready var maxHealthText = $BottomFrameThing/HealthBar/maxHealth
@onready var curHealthText = $BottomFrameThing/HealthBar/healthCount
@onready var nameText = $BottomFrameThing/name
@onready var infoLord = %infoLord

func _ready() -> void:
	pokemonSprite.frame = randi_range(0, 150)
	
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
