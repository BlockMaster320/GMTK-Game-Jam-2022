//test
x += (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * movSpeed;
y += (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * movSpeed;
with (oEnemy)
{
	if point_distance(x, y, other.x, other.y) < 20
		game_restart();
}
