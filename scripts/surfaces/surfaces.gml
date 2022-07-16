function SetupDisplayResolution()
{
	
}

function DrawBoard()
{
	surface_set_target(boardSurface)
	for (var i = 0; i < array_length(tileType); i++)	//Checking tiles top to bottom
	{
		for (var j = 0; j < array_length(tileType[0]); j++)
		{
			if (tileType[i,j] = TILE_TYPE.wall) draw_set_color(c_red)
			else draw_set_color(c_white)
			draw_circle(boardTopX + (i * gridSize),boardTopY + (j * gridSize),2,false)
		}
	}
	surface_reset_target()
}