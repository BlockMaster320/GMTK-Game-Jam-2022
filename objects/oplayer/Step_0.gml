//test
hsp = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * movSpeed;
vsp = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * movSpeed;

if (place_meeting(x+hsp,y,oCollision))
{
	while (!place_meeting(x+sign(hsp),y,oCollision)) x += sign(hsp)
	hsp = 0
}
if (place_meeting(x,y+vsp,oCollision))
{
	while (!place_meeting(x,y+sign(vsp),oCollision)) y += sign(vsp)
	vsp = 0
}

with (oEnemy)
{
	if point_distance(x, y, other.x, other.y) < 20
		game_restart();
}

x += hsp
y += vsp