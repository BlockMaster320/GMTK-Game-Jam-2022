abilityList = array_create(6,ABILITY.none)	//Which ability is on each dice number
abilityList[6-1] = ABILITY.diceReset	//Testing

//Level setup
currentLevel =
{
	budget: 100,	//amount of money available for the level
	unlockedItems: ABILITY.length, //amount of unlocked items
	itemPrices: array_create(ABILITY.length,10) //Setup prices of abilities
}

//Change properties for each level individualy
switch (room)
{
	case (rLvl1):
		currentLevel.budget = 250
		currentLevel.unlockedItems = 1
		break
}

//Dice properties
diceX = oStartingPosition.x
diceY = oStartingPosition.y
movesRemaining = 6
currentNumber = 1

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
boardTopX = 34	//Top left corner of the grid in room coordinates
boardTopY = 34
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
	}
	other.tileType[gridX,gridY] = type
	instance_destroy(self)
}
with (oStartingPosition)
{
	other.startX = (x - other.boardTopX) / other.gridSize
	other.startY = (y - other.boardTopY) / other.gridSize
	instance_destroy(self)
}
with (oFinish)
{
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

for (var i = array_length(abilityList)-1; i > 0; i--)
{
	abilityListCopy[i] = abilityList[i]
}

show_debug_message(tileType)

//Setup drawing surface
boardSurface = surface_create(gridW * gridSize, gridH * gridSize)
DrawBoard()

//Dice properties
diceX = startX
diceY = startY
moveDir = [0,0]
finished = false
failedScreen = false

rollDelayFrames = 16
canRoll = true
//Je to hlupě napsane, ale když jsem to dal na víc řádků tak to nejelo
rollDelay = time_source_create(time_source_game,rollDelayFrames,time_source_units_frames,function()
{
	canRoll = true
	moveDir = [0,0]
	rollPosOffsetX = 0
	rollPosOffsetY = 0
	tileType[diceX,diceY] = TILE_TYPE.numbered
	numberOnTile[diceX,diceY] = 6 - currentNumber
	if (movesRemaining == 0 && !finished)
	{
		failedScreen = true
		canRoll = false
	}
	else if (finished) gameState = PHASE.offense
	else
	{
		ExecuteAbility(currentNumber)	//Use ability with current number if possible
		RedrawTile(diceX,diceY)
	}
},[],1)

rollPosOffsetX = 0
rollPosOffsetY = 0
