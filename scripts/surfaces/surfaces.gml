function RescalingSetup()
{
	application_surface_draw_enable(true)
}

function ResizeBasedOnWindowSize()
{
	if (window_get_width() != 0)
		surface_resize(application_surface,window_get_width(),window_get_height())
}

function DrawBoard()
{
	surface_set_target(boardSurface)
	for (var i = 0; i < array_length(tileType); i++)	//Checking tiles top to bottom
	{
		for (var j = 0; j < array_length(tileType[0]); j++)
		{
			var xx = i * gridSize
			var yy = j * gridSize
			switch (tileType[i][j])
			{
				case TILE_TYPE.empty:
					draw_sprite(sTiles,irandom_range(0,7),xx,yy)
					break
					
				case TILE_TYPE.numbered:
					draw_sprite(sNumbers,numberOnTile[i][j]-1,xx,yy)
					break
					
				case TILE_TYPE.wall:
					var index = irandom_range(1,6)
					if (random(100) < .5) index = 0
					draw_sprite(sCollision,index,xx,yy)
					break
					
				case TILE_TYPE.turretBasic:
					draw_sprite(sTiles,0,xx,yy)
					break
					
			}
		}
	}
	surface_reset_target()
}

function RedrawTile(xx, yy)
{
	surface_set_target(boardSurface)
	var xxx = xx * gridSize
	var yyy = yy * gridSize
	switch (tileType[xx][yy])
	{
		case TILE_TYPE.numbered:
			draw_sprite(sNumbers,currentNumber-1,xxx, yyy)
			break
		
		case TILE_TYPE.empty:
			draw_sprite(sTiles,0,xxx,yyy)
			break
					
		case TILE_TYPE.wall:
			draw_sprite(sCollision,0,xxx,yyy)
			break
					
		case TILE_TYPE.turretBasic:
			draw_sprite(sTiles,0,xxx,yyy)
			break
					
	}
	surface_reset_target()
}

function BoardReset()
{
	failedScreen = false
	movesRemaining = 0
	currentNumber = 1
	gameState = PHASE.shop
	coinsAmount = currentLevel.budget
	abilityActive = ABILITY.none
	with (oShieldedTile) instance_destroy(self);
	for (var i = 0; i < 13; i++)	//Checking tiles top to bottom
	{
		for (var j = 0; j < 6; j++)
		{
			tileType[i][j] = tileTypeCopy[i][j]
		}	
	}
	
	for (var i = array_length(abilityArray)-1; i > 0; i--)
	{
		abilityArray[i] = abilityArrayCopy[i]
	}

	diceX = startX
	diceY = startY
	
	currentSoldierId = 0
	ds_list_clear(walkedOverListX)
	ds_list_clear(walkedOverListY)
	
	SpawnSoldiers()
	
	var snd = choose(sndRestart,sndRestart2)
	audio_play_sound(snd,0,0)
	
	DrawBoard()
}