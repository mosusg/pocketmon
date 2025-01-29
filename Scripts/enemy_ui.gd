extends Node2D

@onready var pokemonSprite = $pokemon
@onready var levelText = $BottomFrameThing/level
@onready var maxHealthText = $BottomFrameThing/HealthBar/maxHealth
@onready var curHealthText = $BottomFrameThing/HealthBar/healthCount
@onready var nameText = $BottomFrameThing/name
@onready var healthBar = $BottomFrameThing/healthBarREAL
@onready var infoLord = %infoLord
var maxHp : int
var curHp : int
var level = randi_range(60, 84)



func _ready() -> void:
	initializePokemon()
	
	healthBar.value = float(curHp)/float(maxHp) * 100
	print(healthBar.value)
	levelText.set_text(str(level))

func initializePokemon():
	pokemonSprite.frame = randi_range(0, 5)
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	maxHp = ((((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (pow(252, 1) / 4)) * level) / 100) + level + 10
	curHp = randi_range(1, maxHp)
