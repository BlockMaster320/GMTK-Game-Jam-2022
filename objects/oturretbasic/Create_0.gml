xx = 0;
yy = 0;

//Function firing a bullet at a soldier
fire = function()
{
	var _gridSize = oController.gridSize;
	var _colliderArray = array_create(4, noone);
	_colliderArray[0] = collision_rectangle(x + _gridSize, y, x + _gridSize * 2 - 2, y + _gridSize - 2, oSoldier, 0, true);
	if (collision_rectangle(x + _gridSize, y, x + _gridSize * 2 - 2, y + _gridSize - 2, oShieldedTile, 0, true)) _colliderArray[0] = noone;
	_colliderArray[1] = collision_rectangle(x - _gridSize, y, x - 2, y + _gridSize - 2, oSoldier, 0, true);
	if (collision_rectangle(x - _gridSize, y, x - 2, y + _gridSize - 2, oShieldedTile, 0, true)) _colliderArray[1] = noone;
	_colliderArray[2] = collision_rectangle(x, y + _gridSize, x + _gridSize - 2, y + _gridSize * 2 - 2, oSoldier, 0, true);
	if (collision_rectangle(x, y + _gridSize, x + _gridSize - 2, y + _gridSize * 2 - 2, oShieldedTile, 0, true)) _colliderArray[2] = noone;
	_colliderArray[3] = collision_rectangle(x, y - _gridSize, x + _gridSize - 2, y - 2, oSoldier, 0, true);
	if (collision_rectangle(x, y - _gridSize, x + _gridSize - 2, y - 2, oShieldedTile, 0, true)) _colliderArray[3] = noone;
	
	for (var _i = 0; _i < array_length(_colliderArray); _i++)
	{
		var _soldier = _colliderArray[_i];
		if (_soldier != noone)
		{
			_soldier.bulletTime = BULLET_SPEED;
			_soldier.bulletX = x;
			_soldier.bulletY = y;
			return;
		}
	}
}

fireTimeSource = time_source_create(time_source_game, BULLET_COOLDOWN, time_source_units_seconds, fire, [], -1);
time_source_start(fireTimeSource);
