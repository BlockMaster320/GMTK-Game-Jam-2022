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
			if (up) moveDir[1] = -1
			else if (down) moveDir[1] = 1
			else if (left) moveDir[0] = -1
			else if (right) moveDir[0] = 1
			return noone
		}
	}
	if (up)
	{
		if (diceY == 0) return noone	//Na 2 řádcích, aby to nehodilo error že array neexistuje
		if (tileType[diceX,diceY-1] != TILE_TYPE.empty) return noone
		diceY--
		moveDir[1] = -1
	}
	if (down)
	{
		if (diceY == gridH-1) return noone
		if (tileType[diceX,diceY+1] != TILE_TYPE.empty) return noone
		diceY++
		moveDir[1] = 1
	}
	if (left)
	{
		if (diceX == 0) return noone
		if (tileType[diceX-1,diceY] != TILE_TYPE.empty) return noone
		diceX--
		moveDir[0] = -1
	}
	if (right)
	{
		if (diceX == gridW-1) return noone
		if (tileType[diceX+1,diceY] != TILE_TYPE.empty) return noone
		diceX++
		moveDir[0] = 1
	}
	
	canRoll = false
	time_source_start(oController.rollDelay)
	movesRemaining--
	currentNumber = 7 - movesRemaining
}