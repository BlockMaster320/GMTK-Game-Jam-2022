function ExecuteAbility()
{
	switch (currentNumber)
	{
		case ABILITY.none:
			break
			
		case ABILITY.diceReset:
			movesRemaining = 6
			abilityList[currentNumber] = ABILITY.none	//One time use
			break
	}
}