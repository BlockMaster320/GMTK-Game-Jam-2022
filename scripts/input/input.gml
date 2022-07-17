function Input()
{
	up = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"))
	down = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"))
	left = keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))
	right = keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))
	
	lmbPress = mouse_check_button_pressed(mb_left)
	lmbHold = mouse_check_button(mb_left)
	lmbRelease = mouse_check_button_released(mb_left)
	
	enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)
	reset = keyboard_check_pressed(ord("R"))
	leave = keyboard_check_pressed(vk_escape)
	
	if (keyboard_check_pressed(ord("F"))) window_set_fullscreen(!window_get_fullscreen())
	
	spawnSoldier = enter
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
		if (tileType[diceX,diceY-1] != TILE_TYPE.empty) return noone
		diceY--
		moveDir[1] = -1
		diceSprite = sDiceRollUp
	}
	if (down)
	{
		if (diceY == gridH-1) return noone
		if (tileType[diceX,diceY+1] != TILE_TYPE.empty) return noone
		diceY++
		moveDir[1] = 1
		diceSprite = sDiceRollDown
	}
	if (left)
	{
		if (diceX == 0) return noone
		if (tileType[diceX-1,diceY] != TILE_TYPE.empty) return noone
		diceX--
		moveDir[0] = -1
		diceSprite = sDiceRollLeft
	}
	if (right)
	{
		if (diceX == gridW-1) return noone
		if (tileType[diceX+1,diceY] != TILE_TYPE.empty) return noone
		diceX++
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