abilityArray = array_create(7, ABILITY.none)	//Which ability is on each dice number
//abilityArray[6-1] = ABILITY.diceReset	//Testing

coinsAmount = 0;
abilityActive = ABILITY.none;

win = false;

//Level setup
currentLevel =
{
	budget: 100,	//amount of money available for the level
	abilities: [],
	soldierAmount: 5,
	spawnCooldownDef : 35,
	dialogArray: []
}

//Change properties for each level individualy
switch (room)
{
	case (rLvl1):
		currentLevel.budget = 0
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = []	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 3
		currentLevel.dialogArray = ["Welcome to Aleaspira! \nThe land named after the tabletop game... \nAleaspira!", "The game has 3 PHASES: GEAR UP, ROLLING and TOWER OFFENSE.", "For now, press SPACE or UP ARROW to start the rolling phase",
		"To move in the ROLLING use WASD or ARROW keys but be aware! You can only move as many times as many sides the cube has."]
		break
		
	case (rLvl2):
		currentLevel.budget = 0
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = []	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 1
		currentLevel.dialogArray = ["After you reach the finish by rolling the dice, at least one of your troops needs to get there as well","Evade the tower that's in your way!"]
		break
		
	case (rLvl3):
		currentLevel.budget = 0
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = []	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 3
		break
		
	case (rLvl4):
		currentLevel.budget = 3
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.armor,3]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 1
		currentLevel.dialogArray = ["Now, let's go shopping.","You have a limited budget for each encounter.","Buy ARMOR by dragging the icon on one of your slots","When your troops stand on the number of the slot, the towers can't target them."]
		break
		
	case (rLvl5):
		currentLevel.budget = 4
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.armor,2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 2
		currentLevel.dialogArray = ["If the prices are low enough, you can even buy multiple of same item!","Oh I'm so generous..."]
		break
		
	case (rLvl6):
		currentLevel.budget = 3
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.diceReset,3]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 2
		currentLevel.dialogArray = ["Now things are going to get wild!","When you reach the number of the slot for the first time, the DICE RESET resets the number on your dice back to one.","Try it out!"]
		break
		
	case (rLvl7):
		currentLevel.budget = 4
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.diceReset,2],[ABILITY.armor,2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 1
		break
		
	case (rLvl8):
		currentLevel.budget = 4
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.diceReset,2],[ABILITY.armor,2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 2
		currentLevel.spawnCooldownDef = 100
		break
		
	case (rLvl9):
		currentLevel.budget = 5
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.diceReset,1],[ABILITY.armor,2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 2
		currentLevel.dialogArray = ["Let's test your brains out.","Not in a way a similar plants game does it but you know...","There are 2 ways to solve this level."]
		break
		
	case (rLvl10):
		currentLevel.budget = 2
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.diceReset,2],[ABILITY.armor,2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierAmount = 25
		currentLevel.spawnCooldownDef = 10
		currentLevel.dialogArray = ["Sometimes, endurance wins above surviving..."]
		break
}

oDialogs.dialogArray = currentLevel.dialogArray;
oDialogs.dialogNum = 0;

if (array_length(oDialogs.dialogArray) > 0)
{
	var snd = choose(sndTalking,sndTalking2,sndTalking3,sndTalking4)
	audio_play_sound(snd,0,0)
}


//Dice properties
diceX = oStartingPosition.x
diceY = oStartingPosition.y
movesRemaining = 6
currentNumber = 1

dashDist = 3
dashAnimOffsetMultiplier = 1

//Setup game state
gameState = PHASE.shop


//Initialize level based on object placements in the room
for (var i = 0; i < 13; i++)	//Checking tiles top to bottom
{
	for (var j = 0; j < 6; j++)
	{
		tileType[i][j] = TILE_TYPE.empty
		numberOnTile[i][j] = 0
	}
}
boardTopX = 12	//Top left corner of the grid in room coordinates
boardTopY = 11
gridSize = 17	//1 pixel space between the tiles
gridW = 13
gridH = 6

with (oBoardPiece)
{
	var gridX = (x - other.boardTopX) / other.gridSize
	var gridY = (y - other.boardTopY) / other.gridSize
	var type = 0
	switch (object_index)
	{
		case oCollision: {type = TILE_TYPE.wall; break;}
		case oTurretBasic:
			x = other.gridSize * (x div other.gridSize+1) - 5
			y = other.gridSize * (y div other.gridSize+1) - 6
			type = TILE_TYPE.turretBasic
			show_debug_message("gridX" + string(gridX));
			xx = gridX
			yy = gridY
			break
		case oHole:
			type = TILE_TYPE.hole
			break
	}
	other.tileType[gridX,gridY] = type
	if (object_index != oTurretBasic) instance_destroy(self)
}



with (oStartingPosition)
{
	x = other.gridSize * (x div other.gridSize+1) - 5
	y = other.gridSize * (y div other.gridSize+1) - 6
	other.startX = (x - other.boardTopX) / other.gridSize
	other.startY = (y - other.boardTopY) / other.gridSize
	instance_destroy(self)
}
with (oFinish)
{
	x = other.gridSize * (x div other.gridSize+1) - 5
	y = other.gridSize * (y div other.gridSize+1) - 6
	other.finishX = (x - other.boardTopX) / other.gridSize
	other.finishY = (y - other.boardTopY) / other.gridSize
	instance_destroy(self)
}

//Copy the position array for level reseting
for (var i = 0; i < 13; i++)	//Checking tiles top to bottom
{
	for (var j = 0; j < 6; j++)
	{
		tileTypeCopy[i][j] =  tileType[i][j]
	}	
}
show_debug_message(tileType)

for (var i = array_length(abilityArray)-1; i > 0; i--)
{
	abilityArrayCopy[i] = abilityArray[i]
}

//Spawn soldiers
SpawnSoldiers()

//Setup drawing surface
boardSurface = surface_create(gridW * gridSize, gridH * gridSize)
abilitySurface = surface_create(room_width, room_height);
display_set_gui_size(room_width, room_height);
DrawBoard()

//Dice properties
diceX = startX
diceY = startY
moveDir = [0,0]

diceAlpha = 1
diceSprite = sDice
diceSubimg = 0
rollAnimLengthPerFrame = 7	//Délka rollování
rollAnimLength = 3	//Neměnit
transformAnimLengthPerFrame = 3	//Délka transformace na číslo
transformAnimLength = 5	//Neměnit
rollingAnimation = time_source_create(time_source_game,rollAnimLengthPerFrame,time_source_units_frames,RollAnimation,[],rollAnimLength)
transformAnimation = time_source_create(time_source_game,transformAnimLengthPerFrame,time_source_units_frames,TransformAnimation,[],transformAnimLength)

finished = false
failedScreen = false

rollDelayFrames = rollAnimLengthPerFrame * rollAnimLength + transformAnimLengthPerFrame * transformAnimLength
rollProgress = 0
canRoll = true
//Je to hlupě napsane, ale když jsem to dal na víc řádků tak to nejelo
rollDelay = time_source_create(time_source_game,rollDelayFrames,time_source_units_frames,function()
{
	diceSubimg = 0
	diceSprite = sDice
	
	canRoll = true
	moveDir = [0,0]
	rollPosOffsetX = 0
	rollPosOffsetY = 0
	tileType[diceX,diceY] = TILE_TYPE.numbered
	numberOnTile[diceX,diceY] = currentNumber
	dashAnimOffsetMultiplier = 1
	if (movesRemaining == 0 && !finished && (finishX != diceX || finishY != diceY))
	{
		failedScreen = true
		canRoll = false
	}
	else if (finished)
	{
		finished = false
		gameState = PHASE.offense
	}
	else
	{
		ExecuteAbility(currentNumber)	//Use ability with current number if possible
		ds_list_add(walkedOverListX,diceX)
		ds_list_add(walkedOverListY,diceY)
		show_debug_message(abilityArray)
	}
	RedrawTile(diceX,diceY)
},[],1)

rollPosOffsetX = 0
rollPosOffsetY = 0

//Offense
currentSoldierId = 0
walkedOverListX = ds_list_create()
walkedOverListY = ds_list_create()
spawnCooldown = 0
