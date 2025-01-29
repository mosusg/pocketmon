extends Node2D

@onready var pokemonSprite = $pokemon
@onready var levelText = $BottomFrameThing/level
@onready var maxHealthText = $BottomFrameThing/HealthBar/maxHealth
@onready var curHealthText = $BottomFrameThing/HealthBar/healthCount
@onready var nameText = $BottomFrameThing/name
@onready var infoLord = %infoLord
var maxHp : int
var curHp : int
var level = randi_range(60, 84)

func _ready() -> void:
	pokemonSprite.frame = randi_range(0, 5)
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	
	#print(infoLord.pokemon[pokemonSprite.frame]["HP"])
	
	#maxHp = (((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"] + 15) * 2) + (pow(252, 1) / 4) * level) * 1) / 100) + level + 10
	maxHp = ((((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (pow(252, 1) / 4)) * level) / 100) + level + 10
	
	levelText.set_text(str(level))
	maxHealthText.set_text(str(maxHp))
	curHealthText.set_text(str(maxHp))
