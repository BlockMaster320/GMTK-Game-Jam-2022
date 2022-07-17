xx = 0;
yy = 0;

//Function firing a bullet at a soldier
fire = function()
{
	var _gridSize = oController.gridSize;
	var _colliderArray = array_create(4, noone);
	var bruhOffset = 3
	_colliderArray[0] = collision_rectangle(x + _gridSize+bruhOffset, y+bruhOffset, x + _gridSize * 2 - 2-bruhOffset, y + _gridSize - 2-bruhOffset, oSoldier, 0, true);
	if (collision_rectangle(x + _gridSize+bruhOffset, y+bruhOffset, x + _gridSize * 2 - 2-bruhOffset, y + _gridSize - 2-bruhOffset, oShieldedTile, 0, true)) _colliderArray[0] = noone;
	_colliderArray[1] = collision_rectangle(x - _gridSize+bruhOffset, y, x - 2-bruhOffset, y + _gridSize - 2-bruhOffset, oSoldier, 0, true);
	if (collision_rectangle(x - _gridSize+bruhOffset, y+bruhOffset, x - 2-bruhOffset, y + _gridSize - 2-bruhOffset, oShieldedTile, 0, true)) _colliderArray[1] = noone;
	_colliderArray[2] = collision_rectangle(x+bruhOffset, y + _gridSize+bruhOffset, x + _gridSize - 2-bruhOffset, y + _gridSize * 2 - 2-bruhOffset, oSoldier, 0, true);
	if (collision_rectangle(x+bruhOffset, y + _gridSize+bruhOffset, x + _gridSize - 2-bruhOffset, y + _gridSize * 2 - 2-bruhOffset, oShieldedTile, 0, true)) _colliderArray[2] = noone;
	_colliderArray[3] = collision_rectangle(x, y - _gridSize+bruhOffset, x + _gridSize - 2-bruhOffset, y - 2-bruhOffset, oSoldier, 0, true);
	if (collision_rectangle(x+bruhOffset, y - _gridSize+bruhOffset, x + _gridSize - 2-bruhOffset, y - 2-bruhOffset, oShieldedTile, 0, true)) _colliderArray[3] = noone;
	
	for (var _i = 0; _i < array_length(_colliderArray); _i++)
	{
		var _soldier = _colliderArray[_i];
		if (_soldier != noone && _soldier.image_alpha = 1)
		{
			var snd = choose(sndTowerFire1,sndTowerFire2)
			audio_play_sound(snd,0,0)
			
			_soldier.bulletTime = BULLET_SPEED;
			_soldier.bulletX = x + floor(oController.gridSize * 0.5);
			_soldier.bulletY = y + floor(oController.gridSize * 0.5);
			return;
		}
	}
}

fireTimeSource = time_source_create(time_source_game, BULLET_COOLDOWN, time_source_units_seconds, fire, [], -1);
time_source_start(fireTimeSource);
