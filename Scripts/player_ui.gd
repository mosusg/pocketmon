extends Node2D

@onready var pokemonSprite = $pokemon
@onready var levelText = $BottomFrameThing/level
@onready var maxHealthText = $BottomFrameThing/HealthBar/maxHealth
@onready var curHealthText = $BottomFrameThing/HealthBar/healthCount
@onready var nameText = $BottomFrameThing/name
@onready var healthBar = $BottomFrameThing/healthBarREAL
@onready var cursor = $Selector
@onready var actionBox = %ActionBoxFightPokemon
@onready var typeBox = %ActionBoxFightPokemon/TypeBox
@onready var moveTypeLabel = %ActionBoxFightPokemon/TypeBox/type
@onready var moveMaxPP = %ActionBoxFightPokemon/TypeBox/type/maxPP
@onready var moveCurPP = %ActionBoxFightPokemon/TypeBox/type/curPP
@onready var infoLord = %infoLord
var actionTextures = ["res://Assets/images/ui/actionBoxFightPokemon.png", "res://Assets/images/ui/moveBox.png"]
var maxHp : int
var curHp : int
var level = randi_range(60, 84)

var curSelected = 0
var fightState = "main"

func _ready() -> void:
	initializePokemon()
	
	typeBox.visible = false
	actionBox.offset.x = 0
	actionBox.position = Vector2(112, 120)
	actionBox.texture = load(actionTextures[0])
	
	levelText.set_text(str(level))
	maxHealthText.set_text(str(maxHp))

func _process(delta: float) -> void:
	curHealthText.set_text(str(curHp))
	healthBar.value = float(curHp)/float(maxHp) * 100
	
	if fightState == "main":
		actionBox.offset.x = 0
		actionBox.texture = load(actionTextures[0])
		typeBox.visible = false
		
		if Input.is_action_just_pressed("ui_left"):
			cursor.position = Vector2(-33, 86)
			curSelected = 0
		if Input.is_action_just_pressed("ui_right"):
			cursor.position = Vector2(14, 86)
			curSelected = 1
		if Input.is_action_just_pressed("confirm"):
			print("going to moves")
			fightState = "move"
	
	if fightState == "move":
		typeBox.visible = true
		actionBox.offset.x = -16.5
		actionBox.texture = load(actionTextures[1])
		
		if Input.is_action_just_pressed("back"):
			print("moving back to main")
			fightState = "main"
	
	if Input.is_action_pressed("debug"):
		curHp -= 1
func initializePokemon():
	pokemonSprite.frame = randi_range(0, 5)
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	maxHp = ((((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (pow(252, 1) / 4)) * level) / 100) + level + 10
	curHp = randi_range(1, maxHp)
