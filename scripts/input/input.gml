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
}