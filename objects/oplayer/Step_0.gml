//test
hsp = (keyboard_check(ord("D")) - keyboard_check(ord("A"))) * movSpeed;
vsp = (keyboard_check(ord("S")) - keyboard_check(ord("W"))) * movSpeed;

/*if (place_meeting(x+hsp,y,oCollision))
{
	while (!place_meeting(x+sign(hsp),y,oCollision)) x += sign(hsp)
	hsp = 0
}*/
var wallHor = instance_place(x+hsp,y,oCollision)
if (wallHor != noone)
{
	var off = 0
	if (sign(hsp) == 1) off = wallHor.bbox_left - bbox_right
	else off = wallHor.bbox_right - bbox_left
	x += off
	hsp = 0
}

var wallVert = instance_place(x,y+vsp,oCollision)
if (wallVert != noone)
{
	var off = 0
	if (sign(vsp) == 1) off = wallVert.bbox_top - bbox_bottom
	else off = wallVert.bbox_bottom - bbox_top
	y += off
	//while (!place_meeting(x,y+sign(vsp),oCollision)) y += sign(vsp)
	vsp = 0
}

with (oEnemy)
{
	if point_distance(x, y, other.x, other.y) < 20
		game_restart();
}

x += hsp
y += vsp