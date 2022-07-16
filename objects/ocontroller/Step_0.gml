Input()

//Change controll based on game phase
switch (gameState)
{
	case PHASE.shop:
		if (enter) gameState = PHASE.rolling
		break
		
	case PHASE.rolling:
		if (canRoll)
		{
			if (up || down || left || right)
			{
				MoveDice()
			}
		}
		break
		
	case PHASE.offense:
		break
}

show_debug_message(canRoll)
show_debug_message(time_source_get_period(rollDelay))