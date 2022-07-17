abilityArray = array_create(6, ABILITY.none)	//Which ability is on each dice number
//abilityArray[6-1] = ABILITY.diceReset	//Testing

coinsAmount = 0;
abilityActive = ABILITY.none;

//Level setup
currentLevel =
{
	budget: 100,	//amount of money available for the level
	abilities: [],
	soldierAmount: 5,
	soldierSpawnSpd: 60
}

//Change properties for each level individualy
switch (room)
{
	case (rLvl1):
		currentLevel.budget = 5
		coinsAmount = currentLevel.budget;
		currentLevel.abilities = [[ABILITY.dash, 2], [ABILITY.diceReset, 1], [ABILITY.bomb, 2]]	//set unlocked abilities: [ability, price]
		currentLevel.soldierSpawnSpd = 60
		break
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
			x += x % other.gridSize - 5
			y += y % other.gridSize - 6
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
	x += x % other.gridSize - 5
	y += y % other.gridSize - 6
	other.startX = (x - other.boardTopX) / other.gridSize
	other.startY = (y - other.boardTopY) / other.gridSize
	instance_destroy(self)
}
with (oFinish)
{
	x += x % other.gridSize - 5
	y += y % other.gridSize - 6
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
	if (movesRemaining == 0 && !finished)
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
spawnCooldownDef = 20
spawnCooldown = 0
