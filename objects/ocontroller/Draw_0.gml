//DrawBoard
if (!surface_exists(boardSurface))
{
	boardSurface = surface_create(gridW * gridSize, gridH * gridSize)
	DrawBoard()
}
draw_surface(boardSurface,boardTopX,boardTopY)

//Draw based on state
switch (gameState)
{
	case PHASE.shop:
		break
		
	case PHASE.rolling:
		//Dice draw
		var xx = diceX * gridSize + boardTopX + rollPosOffsetX
		var yy = diceY * gridSize + boardTopY + rollPosOffsetY
		draw_sprite(diceSprite,diceSubimg,xx,yy)
		if (failedScreen) draw_text(room_width / 2, room_height / 2,"You didn't finish")
		break
		
	case PHASE.offense:
		break
}


//testing
/*for (var i = 0; i < array_length(tileType); i++)	//Checking tiles top to bottom
{
	for (var j = 0; j < array_length(tileType[0]); j++)
	{
		if (tileType[i][j] = TILE_TYPE.wall) draw_set_color(c_red)
		else draw_set_color(c_white)
		draw_text(boardTopX + (i * gridSize),boardTopY + (j * gridSize),numberOnTile[i][j])
	}
}*/
