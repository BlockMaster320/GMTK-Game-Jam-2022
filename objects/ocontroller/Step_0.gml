Input()
if (win) reset = false

if (leave) room_goto(rMenu)

//if (win) gameState = PHASE.offense

//Change controll based on game phase
switch (gameState)
{
	case PHASE.shop:
		if ((enter or up) && abilityActive == ABILITY.none)
		{
			gameState = PHASE.rolling
			tileType[startX,startY] = TILE_TYPE.numbered
			
			var snd = choose(sndRoll1,sndRoll2,sndRoll3,sndRoll4)
			audio_play_sound(snd,0,0)
			audio_sound_pitch(snd,random_range(.95,1.05))
			canRoll = false
			movesRemaining = 6
			time_source_start(oController.rollDelay)
			time_source_start(rollingAnimation)
			diceSprite = sDiceRollUp
			diceSubimg = 0
			moveDir[1] = -1
			rollPosOffsetY = gridSize //Visual bugfix
		}
		break
		
	case PHASE.rolling:
		if (canRoll)	//Movement
		{
			diceSubimg = (currentNumber - 1) * 4 + 3
			if (finishX == diceX && finishY == diceY) up = true
			if (up || down || left || right)
			{
				MoveDice()
			}
		}
		if (!canRoll)	//Tady nemůže být else, protože se canRoll může změnit v kódu výše
		{
			if (diceSprite != sDice) reset = false
			//Visuální pohyb kostky mezi tily (offsetem)
			var framesLeft = time_source_get_time_remaining(rollDelay)
			var gridOffX = gridSize * moveDir[0]
			var gridOffY = gridSize * moveDir[1]
			if (finished)
			{
				gridOffX = 0
				gridOffY = 0
			}
			var curveChannel = animcurve_get_channel(acMovement,0)
			rollProgress = (rollDelayFrames - framesLeft) / rollDelayFrames
			var interpolated = animcurve_channel_evaluate(curveChannel,rollProgress)
			rollPosOffsetX = (interpolated * moveDir[0] * gridSize - gridOffX) * dashAnimOffsetMultiplier
			rollPosOffsetY = (interpolated * moveDir[1] * gridSize - gridOffY) * dashAnimOffsetMultiplier
			show_debug_message(rollPosOffsetY)
			
			/*var subimgAmount = sprite_get_number(sDiceRollHorizontal)
			if (moveDir[0] != -1 && moveDir[1] != 1) diceSubimg = subimgAmount - ceil(rollProgress * (subimgAmount))
			else diceSubimg = ceil(rollProgress * (subimgAmount)) -.98*/
		}
		if (diceX == finishX and diceY == finishY) diceAlpha -= .1
		if (failedScreen && enter)
		{
			BoardReset()
		}
		break
		
	case PHASE.offense:
		if (spawnSoldier && spawnCooldown <= 0)
		{
			spawnCooldown = currentLevel.spawnCooldownDef
			if (currentSoldierId == 0)
			{
				var snd = sndOffenseStart2
				if (random(100) < 3) snd = sndOffenseStart
				audio_play_sound(snd,0,0)
			}
			var soldierId = currentSoldierId
			with (oSoldier)
			{
				if (soldierId == soldierPosition)
				{
					active = true
					targetX = other.walkedOverListX[|0] * oController.gridSize + oController.boardTopX
					targetY = other.walkedOverListY[|0] * oController.gridSize + oController.boardTopY
				}
			}
			currentSoldierId++
			show_debug_message(currentSoldierId)
		}
		else if (spawnCooldown > 0) spawnCooldown--
		break
}

//Level restart
if (reset) BoardReset()

//show_debug_message(canRoll)
//show_debug_message(time_source_get_period(rollDelay))