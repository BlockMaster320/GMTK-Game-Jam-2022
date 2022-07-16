function ExecuteAbility(num)
{
	switch (abilityArray[num-1])
	{
		case ABILITY.none:
			break
			
		case ABILITY.diceReset:
			movesRemaining = 7
			abilityArray[num-1] = ABILITY.none	//One time use
			break
	}
}