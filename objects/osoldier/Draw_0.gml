if (active) draw_self()
if (bulletTime > 0)
{
	bulletTime--;
	if (bulletTime <= 0)
		instance_destroy(self);
	var _bulletX = lerp(x, bulletX, bulletTime / BULLET_SPEED);
	var _bulletY = lerp(y, bulletY, bulletTime / BULLET_SPEED);
	draw_sprite(sBullet, 1, _bulletX, _bulletY);
}

//draw_text(x,y,soldierPosition)