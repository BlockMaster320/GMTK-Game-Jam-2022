function Input()
{
	up = keyboard_check(vk_up) || keyboard_check(ord("W"))
	down = keyboard_check(vk_down) || keyboard_check(ord("S"))
	left = keyboard_check(vk_left) || keyboard_check(ord("A"))
	right = keyboard_check(vk_right) || keyboard_check(ord("D"))
	
	lmbPress = mouse_check_button_pressed(mb_left)
	lmbHold = mouse_check_button(mb_left)
	lmbRelease = mouse_check_button_released(mb_left)
	
	enter = keyboard_check_pressed(vk_space)
	reset = keyboard_check_pressed(ord("R"))
	leave = keyboard_check_pressed(vk_escape)
	
	if (keyboard_check_pressed(ord("F"))) window_set_fullscreen(!window_get_fullscreen())
	
	//spawnSoldier = keyboard_check(vk_enter) || keyboard_check(vk_space)
	spawnSoldier = true
}

function MoveDice()
{
	if (finishX == diceX && finishY == diceY)
	{
		if ((up and diceY == 0) or (down and diceY == gridH-1) or (left and diceX == 0) or (right and diceX == gridW-1))
		{
			finished = true
			canRoll = false
			movesRemaining = 0
			time_source_start(oController.rollDelay)
			time_source_start(rollingAnimation)
			diceSubimg = 0
			var snd = choose(sndRoll1,sndRoll2,sndRoll3,sndRoll4)
			audio_play_sound(snd,0,0)
			audio_sound_pitch(snd,random_range(.95,1.05))
			if (up) { moveDir[1] = -1; diceSprite = sDiceRollUp }
			else if (down) { moveDir[1] = 1; diceSprite = sDiceRollDown }
			else if (left) { moveDir[0] = -1; diceSprite = sDiceRollLeft }
			else if (right) { moveDir[0] = 1; diceSprite = sDiceRollRight }
			return noone
		}
	}
	if (up)
	{
		if (diceY == 0) return noone	//Na 2 řádcích, aby to nehodilo error že array neexistuje
		
		var moveAmount = 1
		if (abilityArray[currentNumber % 6] == ABILITY.dash)
		{
			for (var i = 1; i <= dashDist; i++)
			{
				try
				{
					if ((tileType[diceX,diceY-i] != TILE_TYPE.empty && tileType[diceX,diceY-i] != TILE_TYPE.hole) || (i == dashDist && tileType[diceX,diceY-i] == TILE_TYPE.hole))
					{
						i = 9999
					}
					else
					{
						moveAmount = i
						if (i != dashDist && tileType[diceX,diceY-dashDist] = TILE_TYPE.empty)
						{
							var xx = (diceX) * gridSize + boardTopX + (gridSize/2)
							var yy = (diceY-i) * gridSize + boardTopY + (gridSize/2)
							instance_create_depth(xx,yy,0,oBridge)
						}
					}
				}
				catch(bruh)
				{
					i = 9999
				}
				
			}
			
		}
		if (moveAmount == 0) return noone
		dashAnimOffsetMultiplier = moveAmount
		
		if (tileType[diceX,diceY-moveAmount] != TILE_TYPE.empty)
		{
			if (abilityArray[currentNumber % 6] == ABILITY.bomb)
			{
				tileType[diceX][diceY - 1] = TILE_TYPE.numbered;
				RedrawTile(diceX, diceY - 1)
			}
			else return noone;
		}
		diceY -= moveAmount
		moveDir[1] = -1
		diceSprite = sDiceRollUp
	}
	else if (down)
	{
		if (diceY == gridH-1) return noone
		var moveAmount = 1
		if (abilityArray[currentNumber % 6] == ABILITY.dash)
		{
			for (var i = 1; i <= dashDist; i++)
			{
				try
				{
					if ((tileType[diceX,diceY+i] != TILE_TYPE.empty && tileType[diceX,diceY-i] != TILE_TYPE.hole) || (i == dashDist && tileType[diceX,diceY-i] == TILE_TYPE.hole))
					{
						i = 9999
					}
					else
					{
						moveAmount = i
						if (i != dashDist && tileType[diceX,diceY+dashDist] = TILE_TYPE.empty)
						{
							var xx = (diceX) * gridSize + boardTopX + (gridSize/2)
							var yy = (diceY+i) * gridSize + boardTopY + (gridSize/2)
							instance_create_depth(xx,yy,0,oBridge)
						}
					}
				}
				catch(bruh)
				{
					i = 9999
				}
			}
			
		}
		if (moveAmount == 0) return noone
		dashAnimOffsetMultiplier = moveAmount
		if (tileType[diceX,diceY+moveAmount] != TILE_TYPE.empty)
		{
			if (abilityArray[currentNumber % 6] == ABILITY.bomb)
			{
				tileType[diceX][diceY + 1] = TILE_TYPE.numbered;
				RedrawTile(diceX, diceY + 1)
			}
			else return noone;
		}
		diceY += moveAmount
		moveDir[1] = 1
		diceSprite = sDiceRollDown
	}
	else if (left)
	{
		if (diceX == 0) return noone
		var moveAmount = 1
		if (abilityArray[currentNumber % 6] == ABILITY.dash)
		{
			for (var i = 1; i <= dashDist; i++)
			{
				try
				{
					if ((tileType[diceX-i,diceY] != TILE_TYPE.empty && tileType[diceX,diceY-i] != TILE_TYPE.hole) || (i == dashDist && tileType[diceX,diceY-i] == TILE_TYPE.hole))
					{
						i = 9999
					}
					else
					{
						moveAmount = i
						if (i != dashDist && tileType[diceX-dashDist,diceY] = TILE_TYPE.empty)
						{
							var xx = (diceX-i) * gridSize + boardTopX + (gridSize/2)
							var yy = (diceY) * gridSize + boardTopY + (gridSize/2)
							instance_create_depth(xx,yy,0,oBridge,{image_angle: 90})
						}
					}
				}
				catch(bruh)
				{
					i = 9999
				}
			}
			
		}
		if (moveAmount == 0) return noone
		dashAnimOffsetMultiplier = moveAmount
		if (tileType[diceX-moveAmount,diceY] != TILE_TYPE.empty)
		{
			if (abilityArray[currentNumber % 6] == ABILITY.bomb)
			{
				tileType[diceX - 1][diceY] = TILE_TYPE.numbered;
				RedrawTile(diceX - 1, diceY)
			}
			else return noone;
		}
		diceX -= moveAmount
		moveDir[0] = -1
		diceSprite = sDiceRollLeft
	}
	else if (right)
	{
		if (diceX == gridW-1) return noone
		var moveAmount = 1
		if (abilityArray[currentNumber % 6] == ABILITY.dash)
		{
			for (var i = 1; i <= dashDist; i++)
			{
				try
				{
					if ((tileType[diceX+i,diceY] != TILE_TYPE.empty && tileType[diceX,diceY-i] != TILE_TYPE.hole) || (i == dashDist && tileType[diceX,diceY-i] == TILE_TYPE.hole))
					{
						i = 9999
					}
					else
					{
						moveAmount = i
						if (i != dashDist && tileType[diceX+dashDist,diceY] = TILE_TYPE.empty)
						{
							var xx = (diceX+i) * gridSize + boardTopX + (gridSize/2)
							var yy = (diceY) * gridSize + boardTopY + (gridSize/2)
							instance_create_depth(xx,yy,0,oBridge,{image_angle: 90})
						}
					}
				}
				catch(bruh)
				{
					i = 9999
				}
			}
			
		}
		if (moveAmount == 0) return noone
		dashAnimOffsetMultiplier = moveAmount
		if (tileType[diceX+moveAmount,diceY] != TILE_TYPE.empty)
		{
			if (abilityArray[currentNumber % 6] == ABILITY.bomb)
			{
				tileType[diceX + 1][diceY] = TILE_TYPE.numbered;
				RedrawTile(diceX + 1, diceY)
			}
			else return noone;
		}
		diceX += moveAmount
		moveDir[0] = 1
		diceSprite = sDiceRollRight
	}
	var snd = choose(sndRoll1,sndRoll2,sndRoll3,sndRoll4)
	audio_play_sound(snd,0,0)
	audio_sound_pitch(snd,random_range(.95,1.05))
	canRoll = false
	time_source_start(rollDelay)
	time_source_start(rollingAnimation)
	diceSubimg = 0
	movesRemaining--
	currentNumber = 7 - movesRemaining
}