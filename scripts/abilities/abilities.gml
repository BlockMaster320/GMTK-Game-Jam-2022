function ExecuteAbility(num)
{
	switch (abilityArray[num-1])
	{
		case ABILITY.none:
			break
			
		case ABILITY.diceReset:
			movesRemaining = 6
			abilityArray[num-1] = ABILITY.none	//One time use
			break
		
		case ABILITY.armor:
			var _diceX = oController.boardTopX + oController.diceX * oController.gridSize;
			var _diceY = oController.boardTopY + oController.diceY * oController.gridSize;
			show_debug_message(_diceX);
			instance_create_depth(_diceX, _diceY, 0, oShieldedTile);
			break;
	}
}
