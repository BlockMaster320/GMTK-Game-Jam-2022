if (active) draw_self()

//Draw a bullet
if (bulletTime > 0)
{
	bulletTime--;
	if (bulletTime <= 0)
	{
		audio_play_sound(sndKill,0,0)
		audio_sound_pitch(sndKill,random_range(.95,1.1))
		instance_destroy(self);
	}
	var _bulletX = lerp(x, bulletX, bulletTime / BULLET_SPEED);
	var _bulletY = lerp(y, bulletY, bulletTime / BULLET_SPEED);
	show_debug_message(ceil((bulletTime / BULLET_SPEED) * 4))
	draw_sprite(sBullet, 4 - ceil((bulletTime / BULLET_SPEED) * 4), _bulletX, _bulletY);
}

//draw_text(x,y,soldierPosition)