function ExecuteAbility(num)
{
	switch (abilityList[num-1])
	{
		case ABILITY.none:
			break
			
		case ABILITY.diceReset:
			movesRemaining = 7
			abilityList[num-1] = ABILITY.none	//One time use
			break
	}
}