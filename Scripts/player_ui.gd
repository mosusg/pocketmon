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
@onready var movesGroup = %ActionBoxFightPokemon/moves
@onready var moveOneText = %ActionBoxFightPokemon/moves/move1
@onready var moveTwoText = %ActionBoxFightPokemon/moves/move2
@onready var moveThreeText = %ActionBoxFightPokemon/moves/move3
@onready var moveFourText = %ActionBoxFightPokemon/moves/move4
@onready var infoLord = %infoLord
var actionTextures = ["res://Assets/images/ui/actionBoxFightPokemon.png", "res://Assets/images/ui/moveBox.png"]
var maxHp : int
var curHp : int
var level = randi_range(60, 84)

var curSelected = 0
var fightState = "main"

func _ready() -> void:
	initializePokemon()
	
	setCursorPos(0)
	
	movesGroup.visible = false
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
		movesGroup.visible = false
		actionBox.offset.x = 0
		actionBox.texture = load(actionTextures[0])
		typeBox.visible = false
		
		if Input.is_action_just_pressed("ui_left"):
			setCursorPos(0)
		if Input.is_action_just_pressed("ui_right"):
			setCursorPos(1)
		if Input.is_action_just_pressed("confirm") and curSelected == 0:
			setCursorPos(2)
			fightState = "move"
	
	if fightState == "move":
		movesGroup.visible = true
		typeBox.visible = true
		actionBox.offset.x = -16.5
		actionBox.texture = load(actionTextures[1])
		
		if Input.is_action_just_pressed("ui_down"):
			if curSelected < 5:
				setCursorPos(curSelected + 1)
			else:
				setCursorPos(2)
		if Input.is_action_just_pressed("ui_up"):
			if curSelected > 2:
				setCursorPos(curSelected - 1)
			else:
				setCursorPos(5)
		if Input.is_action_just_pressed("back"):
			setCursorPos(0)
			fightState = "main"
	
	if Input.is_action_pressed("debug"):
		curHp -= 1
func initializePokemon():
	#pokemonSprite.frame = randi_range(0, 5)
	pokemonSprite.frame = 0
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	maxHp = ((((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (pow(252, 1) / 4)) * level) / 100) + level + 10
	curHp = randi_range(1, maxHp)
	moveOneText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"]["ONE"]["NAME"])
	
func setCursorPos(pos): # Use to set cursor position instead of directly
	# Used for the inital action screen 0 = Fight 1 = party/pkmn
	if pos == 0:
		cursor.position = Vector2(-33, 86)
	elif pos == 1:
		cursor.position = Vector2(14, 86)
	# Used for the moves 2-5 top to bottom
	elif pos == 2:
		cursor.position = Vector2(-65, 78)
	elif pos == 3:
		cursor.position = Vector2(-65, 86)
	elif pos == 4:
		cursor.position = Vector2(-65, 94)
	elif pos == 5:
		cursor.position = Vector2(-65, 102)
		
	curSelected = pos
