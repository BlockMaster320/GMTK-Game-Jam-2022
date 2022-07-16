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
	
	if (keyboard_check_pressed(ord("F"))) window_set_fullscreen(!window_get_fullscreen())
}

function MoveDice()
{
	if (up && diceY != 0)
	{
		if (tileType[diceX,diceY-1] != TILE_TYPE.empty) return noone
		diceY--
	}
	canRoll = false
	time_source_start(oController.rollDelay)
}