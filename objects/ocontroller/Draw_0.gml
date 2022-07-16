//testing
for (var i = 0; i < array_length(tileType); i++)	//Checking tiles top to bottom
{
	for (var j = 0; j < array_length(tileType[0]); j++)
	{
		if (tileType[i,j] = TILE_TYPE.wall) draw_set_color(c_red)
		else draw_set_color(c_white)
		draw_circle(boardTopX + (i * gridSize),boardTopY + (j * gridSize),2,false)
	}
}

//DrawBoard
draw_surface(boardSurface,boardTopX,boardTopY)

//Draw based on state
switch (gameState)
{
	case PHASE.shop:
		break
		
	case PHASE.rolling:
		break
		
	case PHASE.offense:
		break
}