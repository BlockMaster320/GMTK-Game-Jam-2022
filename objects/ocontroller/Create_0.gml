abilityList = array_create(6,ABILITY.none)	//Which ability is on each dice number

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
//tileType[12][5] = TILE_TYPE.empty	//13x6 grid
for (var i = 0; i < 13; i++)	//Checking tiles top to bottom
{
	for (var j = 0; j < 6; j++)
	{
		tileType[i][j] = TILE_TYPE.empty
	}	
}
boardTopX = 34	//Top left corner of the grid in room coordinates
boardTopY = 34
gridSize = 17	//1 pixel space between the tiles
gridW = 13
gridH = 6

/*for (var i = 0; i < array_length(tileType); i++)	//Checking tiles left to right
{
	for (var j = 0; j < array_length(tileType[0]); j++)
	{
		
	}
}*/

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
}
with (oStartingPosition)
{
	startX = (x - other.boardTopX) % other.gridSize
	startY = (y - other.boardTopY) % other.gridSize
}
with (oFinish)
{
	finishX = (x - other.boardTopX) % other.gridSize
	finishY = (y - other.boardTopY) % other.gridSize
}

show_debug_message(tileType)

//Setup drawing surface
boardSurface = surface_create(gridW * gridSize, gridH * gridSize)



