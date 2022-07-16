Input()

if (leave) room_goto(rMenu)

//Change controll based on game phase
switch (gameState)
{
	case PHASE.shop:
		if (enter)
		{
			gameState = PHASE.rolling
			tileType[startX,startY] = TILE_TYPE.numbered
			
			canRoll = false
			movesRemaining = 6
			time_source_start(oController.rollDelay)
			moveDir[1] = -1
			rollPosOffsetY = gridSize //Visual bugfix
		}
		break
		
	case PHASE.rolling:
		if (canRoll)	//Movement
		{
			if (up || down || left || right)
			{
				MoveDice()
			}
		}
		if (!canRoll)	//Tady nemůže být else, protože se canRoll může změnit v kódu výše
		{
			//Visuální pohyb kostky mezi tily (offsetem)
			var framesLeft = time_source_get_time_remaining(rollDelay)
			var gridOffX = gridSize * moveDir[0]
			var gridOffY = gridSize * moveDir[1]
			if (finished)
			{
				gridOffX = 0
				gridOffY = 0
			}
			rollPosOffsetX = (rollDelayFrames - framesLeft) / rollDelayFrames * moveDir[0] * gridSize - gridOffX
			rollPosOffsetY = (rollDelayFrames - framesLeft) / rollDelayFrames * moveDir[1] * gridSize - gridOffY
		}
		if (failedScreen && enter)
		{
			BoardReset()
		}
		break
		
	case PHASE.offense:
		break
}

//Level restart
if (reset) BoardReset()

show_debug_message(canRoll)
show_debug_message(time_source_get_period(rollDelay))