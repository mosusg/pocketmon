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

var monPicked = 0
var ACCEPTABLECHOICES = randi_range(0, 4)

func _ready() -> void:
	if ACCEPTABLECHOICES == 0:
		monPicked = 0
	elif ACCEPTABLECHOICES == 1:
		monPicked = 3
	elif ACCEPTABLECHOICES == 2:
		monPicked = 24
	elif ACCEPTABLECHOICES == 3:
		monPicked = 111
	else:
		monPicked = 133
		
	pokemonSprite.frame = monPicked
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	
	#print(infoLord.pokemon[pokemonSprite.frame]["HP"])
	
	maxHp = (((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"] + 15) * 2) + (pow(252, 1) / 4) * level) * 1) / 100) + level + 10
	#maxHp = (((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (pow(252, 1/2) / 4) * level) / 100) + level + 10
	
	levelText.set_text(str(level))
	maxHealthText.set_text(str(maxHp))
	curHealthText.set_text(str(maxHp))
