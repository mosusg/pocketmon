extends Node2D

@onready var pokemonSprite = $pokemon
@onready var levelText = $BottomFrameThing/level
@onready var maxHealthText = $BottomFrameThing/HealthBar/maxHealth
@onready var curHealthText = $BottomFrameThing/HealthBar/healthCount
@onready var nameText = $BottomFrameThing/name
@onready var healthBar = $BottomFrameThing/healthBarREAL
@onready var cursor = $"../../Selector"
@onready var uiCoolDown = $uiTimer
@onready var battleScreenContainer = %BattleScreen
@onready var actionBox = %ActionBoxFightPokemon
@onready var typeBox = %ActionBoxFightPokemon/TypeBox
@onready var moveTypeLabel = %ActionBoxFightPokemon/TypeBox/type
@onready var moveMaxPPLabel = %ActionBoxFightPokemon/TypeBox/type/maxPP
@onready var moveCurPPLabel = %ActionBoxFightPokemon/TypeBox/type/curPP
@onready var movesGroup = %ActionBoxFightPokemon/moves
@onready var moveOneText = %ActionBoxFightPokemon/moves/move1
@onready var moveTwoText = %ActionBoxFightPokemon/moves/move2
@onready var moveThreeText = %ActionBoxFightPokemon/moves/move3
@onready var moveFourText = %ActionBoxFightPokemon/moves/move4

@onready var pkmn1Name = %PartyScreen/partyMonIcon1/name
@onready var pkmn1MaxHPTEXT = %PartyScreen/partyMonIcon1/HealthBar/maxHealth
var pkmn1MaxHPVALUE = 1
@onready var pkmn1CurHPTEXT = %PartyScreen/partyMonIcon1/HealthBar/healthCount
@onready var pkmn1IconTEXT = %PartyScreen/partyMonIcon1


@onready var pkmnScreen = %PartyScreen

@onready var infoLord = %infoLord
var actionTextures = ["res://Assets/images/ui/actionBoxFightPokemon.png", "res://Assets/images/ui/moveBox.png"]
var canClick = true
var maxHp : int
var curHp : int
var moveOnePPUsed : int
var moveTwoPPUsed : int
var moveThreePPUsed : int
var moveFourPPUsed : int
var level : int
var randomLevel = randi_range(1, 100)
var party = {
	"0" : {
		"NUM" : 0,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
	"1" : {
		"NUM" : 1,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
	"2" : {
		"NUM" : 2,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
	"3" : {
		"NUM" : 3,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
	"4" : {
		"NUM" : 4,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
	"5" : {
		"NUM" : 5,
		"MAXHP": 1,
		"CURHP": 1,
		"ATTACK" : 1,
		"DEFENSE" : 1,
		"SPECIAL" : 1,
		"SPEED" : 1,
		"LEVEL" : 1,
		"STATUS" : 0,
		"ALIVE" : true
	},
}

var curSelected = 0
var fightState = "main"

func _ready() -> void:
	level = randomLevel
	initializePokemon()
	
	setCursorPos(0)
	
	pkmnScreen.visible = false
	
	movesGroup.visible = false
	typeBox.visible = false
	actionBox.offset.x = 0
	actionBox.position = Vector2(112, 120)
	actionBox.texture = load(actionTextures[0])
	
	party["0"]["CURHP"] = curHp
	party["0"]["MAXHP"] = maxHp
	
	levelText.set_text(str(level))
	maxHealthText.set_text(str(maxHp))	
	pkmn1MaxHPTEXT.set_text(str(party["0"]["MAXHP"]))
	pkmn1CurHPTEXT.set_text(str(party["0"]["CURHP"]))

func _process(delta: float) -> void:
	curHealthText.set_text(str(curHp))
	healthBar.value = float(curHp)/float(maxHp) * 100
	
	if fightState == "main":
		battleScreenContainer.visible = true
		pkmnScreen.visible = false
		movesGroup.visible = false
		actionBox.offset.x = 0
		actionBox.texture = load(actionTextures[0])
		typeBox.visible = false
		
		if Input.is_action_just_pressed("ui_left"):
			setCursorPos(0)
		if Input.is_action_just_pressed("ui_right"):
			setCursorPos(1)
		if Input.is_action_just_pressed("confirm") and curSelected == 0 and canClick:
			setCursorPos(2)
			fightState = "move"
			canClick = false
			uiCoolDown.start(0.2)
		elif Input.is_action_just_pressed("confirm") and curSelected == 1 and canClick:
			setCursorPos(6)
			fightState = "party"
			canClick = false
			uiCoolDown.start(0.2)
			pkmnScreen.visible = true
	
	if fightState == "move":
		battleScreenContainer.visible = true
		pkmnScreen.visible = false
		moveTypeLabel.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["TYPE"])
		moveMaxPPLabel.set_text(str(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"]))
		movesGroup.visible = true
		typeBox.visible = true
		actionBox.offset.x = -16.5
		actionBox.texture = load(actionTextures[1])
		
		if curSelected == 2:
			moveCurPPLabel.set_text(str(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"] - moveOnePPUsed))
		if curSelected == 3:
			moveCurPPLabel.set_text(str(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"] - moveTwoPPUsed))
		if curSelected == 4:
			moveCurPPLabel.set_text(str(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"] - moveThreePPUsed))
		if curSelected == 5:
			moveCurPPLabel.set_text(str(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"] - moveFourPPUsed))
		
		
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
			canClick = false
			uiCoolDown.start()
		
		if Input.is_action_just_pressed("confirm") and canClick:
			if curSelected == 2 and moveOnePPUsed < infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"]:
				moveOnePPUsed += 1
			elif curSelected == 3 and moveTwoPPUsed < infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"]:
				moveTwoPPUsed += 1
			elif curSelected == 4 and moveThreePPUsed < infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"]:
				moveThreePPUsed += 1
			elif curSelected == 5 and moveFourPPUsed < infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"][str(curSelected - 1)]["PP"]:
				moveFourPPUsed += 1
			
	if fightState == "party":
		pkmn1Name.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
		
		battleScreenContainer.visible = false
		pkmnScreen.visible = true
		
		if Input.is_action_just_pressed("back"):
			setCursorPos(0)
			fightState = "main"
			canClick = false
			uiCoolDown.start()
	
	if Input.is_action_pressed("debug"):
		curHp -= 1
		
func initializePokemon():
	#pokemonSprite.frame = randi_range(0, 5)
	for pokemon in party.size():
		pass
	pokemonSprite.frame = party["0"]["NUM"]
	nameText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["name"])
	maxHp = ((((((infoLord.pokemon[str(pokemonSprite.frame)]["HP"]) + 15) * 2) + (252 / 4)) * level) / 100) + level + 10
	curHp = maxHp
	moveOneText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"]["1"]["NAME"])
	moveTwoText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"]["2"]["NAME"])
	moveThreeText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"]["3"]["NAME"])
	moveFourText.set_text(infoLord.pokemon[str(pokemonSprite.frame)]["MOVESETONE"]["4"]["NAME"])
	
func setCursorPos(pos): # Use to set cursor position instead of directly
	# Used for the inital action screen 0 = Fight 1 = party/pkmn
	if pos == 0:
		cursor.position = Vector2(76.5, 116.5)
	elif pos == 1:
		cursor.position = Vector2(123.5, 116.5)
	# Used for the moves 2-5 top to bottom
	elif pos == 2:
		cursor.position = Vector2(43.5, 108)
	elif pos == 3:
		cursor.position = Vector2(43.5, 116)
	elif pos == 4:
		cursor.position = Vector2(43.5, 124)
	elif pos == 5:
		cursor.position = Vector2(43.5, 132)
	# Used for the party/pkmn screen
	elif pos == 6:
		cursor.position = Vector2(4, 12)
		
	curSelected = pos

func _on_ui_timer_timeout() -> void:
	canClick = true
