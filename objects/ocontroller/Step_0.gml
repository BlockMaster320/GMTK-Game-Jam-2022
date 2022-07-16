Input()

//Change controll based on game phase
switch (gameState)
{
	case PHASE.shop:
		if (enter) gameState = PHASE.rolling
		break
		
	case PHASE.rolling:
		break
		
	case PHASE.offense:
		break
}

show_debug_message(gameState)